Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9629104C
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Oct 2020 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391251AbgJQHEA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Oct 2020 03:04:00 -0400
Received: from p3plsmtpa11-08.prod.phx3.secureserver.net ([68.178.252.109]:56810
        "EHLO p3plsmtpa11-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729897AbgJQHEA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 17 Oct 2020 03:04:00 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2020 03:04:00 EDT
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id TZzIko6YFQ64uTZzJkATte; Fri, 16 Oct 2020 17:22:21 -0700
X-CMAE-Analysis: v=2.3 cv=RIjN4Lq+ c=1 sm=1 tr=0
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=quMw7rvdrhMgCCBUYJAA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: Question about supporting RDMA Extensions for PMEM
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>,
        linux-rdma@vger.kernel.org
References: <8b3c3c81-c0fd-adb2-52a9-94c73aac7e37@cn.fujitsu.com>
 <b7cc3571-5c4b-d5f1-d4e4-97afba4a7994@talpey.com>
 <20201016223734.GG36674@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <fa3e23a4-49fe-efa2-04dd-1264b352d8cb@talpey.com>
Date:   Fri, 16 Oct 2020 20:22:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016223734.GG36674@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOzcp4T5/intnDpTbR9RH/d42IogDbfcsdfEwzbY81qdiuB5QJiPbTIFwirhLfW9wvtwVTB+KHTPL3p9l8MkhZ0LRKKf7cLfuS/vLcEmhZP+X/NCsB8H
 8X4FosUrlIpqeWfz6d2pNZHcd2/ghyT+wAKqGkZdggdg4p8Gfxo9x8etfEWZmU+wLZdpvRmGtCJmNR/1YQpgCKoCd8JQDRsSKjTbplaxnBcA6IPLwukp0ijx
 DA7Z8Z7IOMaPOCHgAFuFsA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/16/2020 6:37 PM, Jason Gunthorpe wrote:
> On Mon, Oct 12, 2020 at 10:26:32PM -0400, Tom Talpey wrote:
> 
>> In theory, the IBTA SWG is in control of specifying any Verbs changes.
> 
> SWG and IETF should agree on what the general software presentation
> should look like so HW implementations can be compatible.
> 
> It looks fairly straightforward so this probably isn't strictly
> necessary once the one the wire protocol is decided.
> 
> verbs has a life of its own these days outside IBTA/IETF..

For the record, I completely agree with the goal of compatible
interfaces. And, I'm committed to defining it, however I am not
able to participate in IBTA as I am no longer associated with
any IBTA member company. I am active in IETF, which has no such
restriction.

However, it's also important to point out that IETF considers
programming interfaces to be out of scope. The draft-hilland-verbs
document for iWARP was not adopted as a work item, and its
content, while extraordinary useful, is not an IETF product.
As an example, consider TCP and Sockets. IETF owns the former,
and has no input on the latter.

In other words, I think it's on us.

Tom.
