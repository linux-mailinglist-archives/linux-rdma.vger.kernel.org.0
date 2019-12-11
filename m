Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBB511AE40
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 15:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKOuD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 09:50:03 -0500
Received: from p3plsmtpa08-01.prod.phx3.secureserver.net ([173.201.193.102]:58732
        "EHLO p3plsmtpa08-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbfLKOuD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Dec 2019 09:50:03 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 09:50:03 EST
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id f3CMisruAdnJSf3CNiJQT0; Wed, 11 Dec 2019 07:42:44 -0700
Subject: Re: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
To:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma@vger.kernel.org, 3100102071@zju.edu.cn
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
 <20191203020319.15036-2-larrystevenwise@gmail.com>
 <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
 <0f8d9087c48e986d08cf85ef8b59bdca25425eaa.camel@redhat.com>
 <1aee0f71873a4c9da7f965c12419d81333f3a0b4.camel@redhat.com>
 <20191210065410.GK67461@unreal>
 <c20696208c239bd11621ad3101735255738bcc97.camel@redhat.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <5f98ecdc-44d1-e185-19e9-7710c2c7c991@talpey.com>
Date:   Wed, 11 Dec 2019 09:42:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <c20696208c239bd11621ad3101735255738bcc97.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCQ+nJihsZjdOgs4R5UsBj/ZHkY2ck3bgrT/rU73orraWMA/mHyeBbs1uoHHWSdDVYtBITTyfNyCZK3gvj9JB5W5nPXWGTFsgVgGPcEqXEAfgGsoamqW
 734lXzaHv61b0AcAnZ5IhOEVRf8bPEHT++MoXDYFslVxou5qvZMuBPocqRPp1QT4w4AMqqFpEiM2J6+aEL/suIgFmWIQfM931IAvhrEzstydMQlPxpzLGBNK
 LY2UOcXVdZYow/RM9PxGSnAxIN1HSB+6RQk/xW2MJG/lRux/BL4yk0+llV83esnFuJnj9jyHFlkg+yvcQtTPvJ4GMpKSNCD9tdSixIcG6D4=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/10/2019 11:24 PM, Doug Ledford wrote:
> On Tue, 2019-12-10 at 08:54 +0200, Leon Romanovsky wrote:
>> On Mon, Dec 09, 2019 at 02:07:06PM -0500, Doug Ledford wrote:
>>>
>>> I've taken these two patches into for-rc (with fixups to the commit
>>> message on the second, as well as adding a Fixes: tag on the
>>> second).
>>>
>>> I stand by what I said about not needing a compatibility flag or
>>> module
>>> option for the user to set.  However, that isn't to say that we
>>> can't
>>> autodetect old soft-RoCE peers.  If we get a packet that fails CRC
>>> and
>>> has pad bytes, then re-run the CRC without the pad bytes and see if
>>> it
>>> matches.  If it does, we could A) mark the current QP as being to an
>>> old
>>> soft-RoCE device (causing us to send without including the pad bytes
>>> in
>>> the CRC) and B) allocate a struct old_soft_roce_peer and save the
>>> guid
>>> into that struct and then put that struct on a list that we then
>>> search
>>> any time we are creating a new queue pair and if the new queue pair
>>> goes
>>> to a guid in the list, then we immediately flag that qp as being to
>>> an
>>> old soft roce device and get the right behavior.  It would slow down
>>> qp
>>> creation somewhat due to the list search, but probably not enough to
>>> worry about.  No one will be doing a 1,000 node cluster MPI job over
>>> soft-RoCE, so we should never notice the list length causing search
>>> problems.  A patch to do something like that would be welcome.
>>
>> Do you find this implementation needed? I see RXE as a development
>> platform and in my view it is unlikely that someone will run RXE in
>> production with mixture of different kernel versions, which requires
>> such compatibility fallback.
> 
> It's not a requirement, that's why I took the patches as they were.  It
> would just be a "nice to have".

The counterargument to this is that it only extends the protocol bug
into the future, and for one single RoCE implementation. No hardware
implementation will do this, as it violates the protocol. And, it
potentially opens a silent data corruption, by accepting packets which
don't actually pass the checksum.

Personally, I'd say it "nice to avoid", i.e. don't apply such a patch.

MHO.
