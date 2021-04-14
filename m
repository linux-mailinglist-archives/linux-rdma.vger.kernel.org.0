Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B835EB1B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbhDNCu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 22:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhDNCuw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 22:50:52 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB96C061574
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 19:50:30 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i16-20020a9d68d00000b0290286edfdfe9eso7438294oto.3
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 19:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EupS2UoYox846+ws5ITvh6BqRlFMSsxkpChKUuUfGKI=;
        b=KOi+fB6ThwH3v9rw+MG1xfh8lIPCEnAl8WgoNVoE6Fvt2htBO4q3Rn59IFluQO2rTg
         G8WSyiRdpb1TOmvOL1PJ7eYXVO7gJ2cLcW9cMO+NUg/ZL3fbvFvLGvscZxWzTl9KzzV0
         afvEODx4WDseQLF9hMKZWT01raOmM797JG4Rc+diAxa6vljKL07TPMT5F/FZ8FSP8sU5
         ciR/g8tDL91dawC7/C3BXl5vvtPioy5m66w7A4jFK5CGnyS+DmmpTuT5CHkxtLu501mg
         MBhYsPvt+iiQu1Go2ZKPORpP9YBSR91kdkm7vFbV7ktQvb+6uTZvD531KmonD1HmZ84b
         qOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EupS2UoYox846+ws5ITvh6BqRlFMSsxkpChKUuUfGKI=;
        b=dcld8QmtDE2bGipeRUnEmhuZdpVTbEcVuMC3+U1S5LXQOqKi9HKhqlRo/U5ueBQqNC
         hpVqQC6ljY+Cgf+SdgifmbX7/WSMtcA+wDAHSpFISSRO0pqirby5JhaWIEmIr0EQrAX6
         c/n83NGf6NSh92IDf+k/ORxK89MPL/NLn1xFY3yOiR4yiYkOaYJc+T/fFA/TKz/j/viq
         V1Y5nF1biRMQsOaVht3UUStcCEbMDTYvsH0Zu+K1dl6+RVjOhzn1vT6VOGaIqhYyIXr3
         7uNmeh/AQ9TrGh92uZgWRUpUodYpckzuLNfrcNIhd2YHh3uREHZ+C8lHJN2xG7BOZ0o+
         aZPA==
X-Gm-Message-State: AOAM533cvElHfZ/wYhqdqEyVxf9utBtc2Fx2Te4Be/elG4HJ0K6WA5dJ
        eXVw36wH7TLArVRSL9cDtkoswTk8vOY=
X-Google-Smtp-Source: ABdhPJz8m3uZ03O5cYAggxgnHNMJfsuxOlRzGvVE1eUktATSvbvBxmobEgmiCcfl1ol6v37nitNmaw==
X-Received: by 2002:a9d:4f05:: with SMTP id d5mr31009310otl.88.1618368629694;
        Tue, 13 Apr 2021 19:50:29 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:6d7:e95c:f15:6172? (2603-8081-140c-1a00-06d7-e95c-0f15-6172.res6.spectrum.com. [2603:8081:140c:1a00:6d7:e95c:f15:6172])
        by smtp.gmail.com with ESMTPSA id f65sm476672otb.11.2021.04.13.19.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 19:50:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next 1/9] RDMA/rxe: Add bind MW fields to rxe_send_wr
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
 <20210408214040.2956-2-rpearson@hpe.com>
 <20210413231136.GA1385646@nvidia.com>
Message-ID: <eba02326-013f-1707-0db7-209413d2cd6f@gmail.com>
Date:   Tue, 13 Apr 2021 21:50:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413231136.GA1385646@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/13/21 6:11 PM, Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 04:40:33PM -0500, Bob Pearson wrote:
>> Add fields to struct rxe_send_wr in rdma_user_rxe.h to
>> support bind MW work requests from user space and kernel.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>  include/uapi/rdma/rdma_user_rxe.h | 34 ++++++++++++++++++++++++++++++-
>>  1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
>> index 068433e2229d..b9c80ca73473 100644
>> +++ b/include/uapi/rdma/rdma_user_rxe.h
>> @@ -99,7 +99,39 @@ struct rxe_send_wr {
>>  			__u32	remote_qkey;
>>  			__u16	pkey_index;
>>  		} ud;
>> -		/* reg is only used by the kernel and is not part of the uapi */
>> +		struct {
>> +			__aligned_u64	addr;
>> +			__aligned_u64	length;
>> +			union {
>> +				__u32		mr_lkey;
>> +				__aligned_u64	reserved1;
>> +			};
>> +			union {
>> +				__u32		mw_rkey;
>> +				__aligned_u64	reserved2;
>> +			};
>> +			__u32	rkey;
>> +			__u32	access;
>> +			__u32	flags;
>> +		} umw;
>> +		/* The following are only used by the kernel
>> +		 * and are not part of the uapi
>> +		 */
>> +		struct {
>> +			__aligned_u64	addr;
>> +			__aligned_u64	length;
>> +			union {
>> +				struct ib_mr	*mr;
> 
> A kernel struct should not appear in a uapi header, nor should secure
> kernel data ever be stored in user memory.
> 
> I'm completely lost at how all this thinks it is working, we don't
> even have kernel verbs support for memory windows??
> 
> Jason
> 

Hard to see from context but I was copying the existing header file which is used to define the WQE layout
for rxe for *both* user and kernel space. The structs shown in the hunk are contained in a union.
The existing version of the driver has one struct
	union {
		...
		struct {
			...
		} reg;
	} wr;
which is only used in kernel space. Like the old song about the 8x10 glossy pictures, I figured I'd just
add another one and avoid looking up the MWs and MRs for bind in the kernel. This is before I discovered
that you all deleted MW support from the kernel a while back. Not really sure why. Not used I suppose but
it is in the spec.

Clearly only user data for user WRs appear in this for user QPs and only kernel data for kernel QPs.
There isn't any mixing. Since it is a union there is no overhead by including the kernel WQEs. There is no
secret about what the kernel structs are.

How to fix this? Since rxe was written the new variable size WQEs in ib_verbs.h (ib_send_wr and friends) were
added and they could be a better choice. Rxe could take these as its own native wqe and that would reduce
the amount of work on kernel WRs and reduce the amount of code dealing with them from user space. It would
break ABI unfortunately.

The other approach is to, as you suggest, ifdef out the kernel stuff in user space. It works anyway because
you can always add a pointer to an undefined struct as long as you don't try to use it. 

Also as you point out ib_bind_mw doesn't exist anymore so I could get rid of the kmw struct and just use the
rkeys. Could still support a kernel mw implementation later without a change if one showed up. There are some
interesting articles about the security of RDMA wire protocols that strongly suggest using type2 MWs with
randomly chosen rkeys and qp numbers instead of MRs. It's not perfect either but orders of magnitude stronger
protection.

bob
