Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485F15EB16E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 21:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIZTkE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 15:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIZTkD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 15:40:03 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 12:40:02 PDT
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A14FC11810
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 12:40:02 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id ctq8o7e69sfCIctq8ohSCv; Mon, 26 Sep 2022 21:32:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 26 Sep 2022 21:32:30 +0200
X-ME-IP: 86.243.100.34
Message-ID: <7cbe6ea7-3d05-449f-ea06-c98b9078d1df@wanadoo.fr>
Date:   Mon, 26 Sep 2022 21:32:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] headers: Remove some left-over license text in
 include/uapi/rdma/
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     aelior@marvell.com, bharat@chelsio.com,
        kernel-janitors@vger.kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mkalderon@marvell.com, selvin.xavier@broadcom.com,
        yishaih@nvidia.com, zyjzyj2000@gmail.com
References: <6b2b69c1eb89a37b95d17a1e866c2e8173c6fd15.1664113175.git.christophe.jaillet@wanadoo.fr>
 <YzHttWsmFSMR8vCY@nvidia.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YzHttWsmFSMR8vCY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 26/09/2022 à 20:21, Jason Gunthorpe a écrit :
> On Sun, Sep 25, 2022 at 03:39:58PM +0200, Christophe JAILLET wrote:
>> There is already a SPDX-License-Identifier tag, so the corresponding
>> license text can be removed.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
>> ---
>> Changes in the 2 files under rdma/hfi/ is a bit more than just removing
>> the license text. There were some Copyright(c) for GPL and BSD licence.
>> I have simplified it to what look logical to me.
>> But in case it matters, review with care.
> 
> Did you use a script or something to verify that the text being
> removed is word for word identical to the text in LICENSES/ ?

Hi,

Short answer:
============

You are likely right, and patches for BSD like license should certainly 
be left as-is to keep as-is.



Longer answer:
=============

I spot potential candidate with:
   grep -r --include=*.[ch] -A50 SPDX | grep -v SPDX | grep -v staging | 
grep -v usr\/include\/ | grep -C10 License

Then I manually check that the included license is consistent with the 
SPDX-License-Identifier tag.

If they don't match, I propose to change the SPDX tag (see [1] for an 
example)

My grep is not optimal. Looking for GNU or GPL or BSD or... also gives 
some decent results. But all what is done is done.


Honestly, I don't look word by word the text itself.
My point is that if a file states that it is usable under a given 
license, then it should use the term of this license. Otherwise it looks 
pointless to refer to it, no?

Moreover, in the BSD license, some parts of the text can be adjusted to 
the context. (in red in [3]

In "bnxt_re-abi.h", the BSD-2-Clause "THE COPYRIGHT HOLDER OR 
CONTRIBUTORS" has been replaced by "THE AUTHOR AND CONTRIBUTORS".


Giving a 2nd look at it (see [4]), when boilerplate have been removed, 
it was mostly (only?) for GPL-2, which don't have such "red" parts in 
the license text.


So you are likely right, and patches for BSD like license should 
certainly be left as-is to keep this "red places" as-is.

> 
> I had understood this was the reason the original SPDX conversion left
> the license text around?

I don't know. It looks to me that Greg has done some mass update, 
especially in the uapi directory, only adding the 
SPDX-License-Identifier tag.
See [2].

> 
> It looks OK to me, but I didn't check it word for word :)
> 
> Is there a reason this series is coming up now around the uapi
> headers? Are we doing them all or something?

No specific reason for it to happen now.

I chose uapi directory because it is .h files. This is my own 
contribution to the Ingo Molnar's "Fast Kernel Headers".
Smaller header files, faster compilation :)
(even if my clean-ups should be just noise in the overall building time)

I try to send patches in small hunks of related files. This avoids the 
"please split the patch in a serie by maintainer" answer.

I've send ~10 or 15 patches yet. I'll see the enthusiasms (or lack of) 
for such patches before continuing.

> 
> Jason
> 

CJ

[1]: 
https://lore.kernel.org/all/a57505bf6c8ddbd68ff5a320aaf5922ec431e00e.1664117249.git.christophe.jaillet@wanadoo.fr/

[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e2be04c7f9958dde770eeb8b30e829ca969b37bb

[3]: https://spdx.org/licenses/BSD-2-Clause.html

[4]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=grep&q=boilerplate%2Freference
