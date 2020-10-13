Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A028C72A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 04:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgJMCdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 22:33:51 -0400
Received: from p3plsmtpa06-03.prod.phx3.secureserver.net ([173.201.192.104]:35878
        "EHLO p3plsmtpa06-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728770AbgJMCdv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Oct 2020 22:33:51 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 22:33:51 EDT
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id SA1IkixW0InvDSA1Jk7HQF; Mon, 12 Oct 2020 19:26:33 -0700
X-CMAE-Analysis: v=2.3 cv=LpLsNUVc c=1 sm=1 tr=0
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=48vgC7mUAAAA:8 a=gsHt2oX1I18S2ETG6AkA:9 a=QEXdDO2ut3YA:10
 a=F5Kl5K0nGyUA:10 a=w1C3t2QeGrPiZgrLijVG:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: Question about supporting RDMA Extensions for PMEM
To:     "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>,
        linux-rdma@vger.kernel.org
References: <8b3c3c81-c0fd-adb2-52a9-94c73aac7e37@cn.fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b7cc3571-5c4b-d5f1-d4e4-97afba4a7994@talpey.com>
Date:   Mon, 12 Oct 2020 22:26:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <8b3c3c81-c0fd-adb2-52a9-94c73aac7e37@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIYBNiFtRkyj0QsZcXgbb7EnD0ADbXMB/qqKLz5MVnQMFCgEwsjHQRieA6oi4NtFgogrhhtMCYHwBTz6ZIyy5WgBY5xRS+az2KgoF6wof6UwlwkQbLFn
 URf+be+Md7MYQltUwhJjuVbCPEcNijq7wVTXwWqBFYu6F8spHWWhu1+b3s0BZSeAJmpS6fif1ZeTUC61nlYqj4Z0UO/EPKJ5Jj03jFCdjZXyZMFtb6SNOjpD
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/12/2020 4:13 AM, Li, Hao wrote:
> Hi,
> 
> I have noticed that IETF has released a draft of RDMA Extensions for
> PMEM [1]. Does libibverbs has a plan to implement these extensions? Are
> there some good starting points if we want to participate the development.
> Thanks!
> 
> [1]: https://tools.ietf.org/id/draft-talpey-rdma-commit-01.html

The draft you refer to is an individual draft, not an official IETF
release. However, after a lengthy process, the effort is now an official
work item of the NFSv4 working group, since the original STORM WG was
shut down an alternative process had to be determined.

An updated document is in the works, hopefully in October, and may
become a full RFC as the IETF process advances. My coauthors and I look
forward to this.

In the meantime, the IBTA LWG took up a similar task, and we completed
it several months ago. I am not sure when it might be released as an
official Annex, but I assume that is in the works as well. The IBTA
version of the extensions is semantically similar, but does not include
the "Verify" operation which in the iWARP document. Perhaps this will
be added later.

In theory, the IBTA SWG is in control of specifying any Verbs changes.
The Annex does discuss these, but SWG would still need to ratify. If
Fujitsu is an IBTA member, I'd encourage you to support this. IETF, of
course, has no dependency on IBTA, or Verbs, so participating there is
a separate matter. I encourage that participation, too!

Tom.
