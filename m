Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F921CB47
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2020 22:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgGLUPf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 16:15:35 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:55250 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgGLUPf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Jul 2020 16:15:35 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 9124ABC07E;
        Sun, 12 Jul 2020 20:15:30 +0000 (UTC)
Subject: Re: [PATCH] SCSI RDMA PROTOCOL (SRP) TARGET: Replace HTTP links with
 HTTPS ones
To:     Bart Van Assche <bvanassche@acm.org>, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200709194820.27032-1-grandmaster@al2klimov.de>
 <3d230abd-752e-8ac1-e18d-b64561b409ff@acm.org>
 <8fca4633-41ad-7e86-2354-36381bf5c734@al2klimov.de>
 <bf85e454-cccc-37ef-d55f-d44a5c5c51df@acm.org>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>
Message-ID: <c6b97005-e4c7-0a46-37eb-b5bb187ee919@al2klimov.de>
Date:   Sun, 12 Jul 2020 22:15:29 +0200
MIME-Version: 1.0
In-Reply-To: <bf85e454-cccc-37ef-d55f-d44a5c5c51df@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Am 12.07.20 um 21:52 schrieb Bart Van Assche:
> On 2020-07-10 11:12, Alexander A. Klimov wrote:
>> Am 10.07.20 um 16:22 schrieb Bart Van Assche:
>>> On 2020-07-09 12:48, Alexander A. Klimov wrote:
>>>> diff --git a/drivers/infiniband/ulp/srpt/Kconfig b/drivers/infiniband/ulp/srpt/Kconfig
>>>> index 4b5d9b792cfa..f63b34d9ae32 100644
>>>> --- a/drivers/infiniband/ulp/srpt/Kconfig
>>>> +++ b/drivers/infiniband/ulp/srpt/Kconfig
>>>> @@ -10,4 +10,4 @@ config INFINIBAND_SRPT
>>>>          that supports the RDMA protocol. Currently the RDMA protocol is
>>>>          supported by InfiniBand and by iWarp network hardware. More
>>>>          information about the SRP protocol can be found on the website
>>>> -      of the INCITS T10 technical committee (http://www.t10.org/).
>>>> +      of the INCITS T10 technical committee (https://www.t10.org/).
>>>
>>> It is not clear to me how modifying an URL in a Kconfig file helps to
>>> reduce the attack surface on kernel devs?
>>
>> Not on all, just on the ones who open it.
> 
> Is changing every single HTTP URL in the kernel into a HTTPS URL the best
> solution? Is this the only solution? Has it been considered to recommend
> kernel developers who are concerned about MITM attacks to install a browser
> extension like HTTPS Everywhere instead?
I've installed that addon myself.
But IMAO it's just a workaround which is (not available to all browsers, 
not installed by default in any of them and) not even 100% secure unless 
you tick a particular checkbox.

Anyway the majority of maintainers and Torvalds himself agree with my 
solution.

I mean, just look at
git log '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' \
--oneline v5.7..master

Or (better) wait for v5.9-rc1 (and all the yet just applied patches it 
will consist of) *and then* run the command.

> 
> Thanks,
> 
> Bart.
> 
