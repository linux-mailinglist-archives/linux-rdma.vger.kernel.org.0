Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9050A3F361A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 23:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHTVl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 17:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTVl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Aug 2021 17:41:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A96C061575
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 14:40:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso17125539ott.13
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1qDkL7wlY/17md5IxA2SyIMosXTwVSkogI3Ec9oTKIM=;
        b=nMATCwc9yXGQC0kJcJNAYw+qvE731Y5QdSsKvWVgx4qTC6U4oF1Uq4byO/JpDwAIEi
         Vl7rfDB/KN6tEFzulPMEgH+587pQu1iM7RoVw62Sgke1ae6+ndi/Uj/bygN1d7GwWJQx
         6TrNI3DasFdvdUxwJQWJuhpJhjXmvjikf2Cd2TOIvosMKyQT/rO2MsJ0O1wW1yvLL5By
         DkolMrlyyLiZDcM/whCNE01cOBkyAPUlPMNsSHwciVrtiP18xY/zdn1ISEJMXDPoF/PL
         lwvhJevFjt73dzmRJ+P4NjxnhHxJ74Nk4rqzNwBvI9f9iSfClzr3+7+CPuQ7zMqDhWSc
         mzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qDkL7wlY/17md5IxA2SyIMosXTwVSkogI3Ec9oTKIM=;
        b=QdMgiWofCZuwUzBqRxUv/9dzgsqs58W/ioyWLXJ0MX+nNKIejFI1SuHOK9XVfD8qIs
         hAzIuAXwZ/nfOdxEnU1Efht1u85B72jcEW5LrodXck7/NZ39vqWnq+MSg/XaVFeVtkpb
         1hcpAAPS2iYYPUmWxkUVMVTWsRAL10vS3AONlcMzj+fIDUtXP/dPyQpXEDJLNUioFBJ5
         rRrZHEFF3wNdjEaoDa4DswycWhOcjGoAARKS40eYod6+CBsxilJDpaS8hdds2ojHBM2C
         QoDkG8xeoPjHlb7YXa/LajVFB1ONhNp24WfpfhS2tZNcHJ5rpmwnYqR2fo1vVV5nKsv/
         HqgQ==
X-Gm-Message-State: AOAM530rJWyAsaZ+kCOT3KnbNDXGj2Ve18IIbLKlc0Diu7o4qe0OpaLO
        HEMEXUA1j803+ayQENC8EPv6Ww0yucQ=
X-Google-Smtp-Source: ABdhPJzfOJ3qK1FGu3daFfCqy/ec8Y0I+wag6ZM2hKHuO62Nrg58fGfJGrLIPeb9lCwyEMMSHRuPbw==
X-Received: by 2002:aca:5954:: with SMTP id n81mr4770670oib.64.1629495648821;
        Fri, 20 Aug 2021 14:40:48 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:18a5:8e2a:9f3f:746c? (2603-8081-140c-1a00-18a5-8e2a-9f3f-746c.res6.spectrum.com. [2603:8081:140c:1a00:18a5:8e2a:9f3f:746c])
        by smtp.gmail.com with ESMTPSA id q13sm1415537ota.17.2021.08.20.14.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 14:40:48 -0700 (PDT)
Subject: Re: RXE status in the upstream rping using rxe
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <YQmF9506lsmeaOBZ@unreal>
 <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal>
 <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <CAN-5tyG4kBYBEaCDPGr=gUTNGkcoznMUy8e4BwCzWZkSPG-=+Q@mail.gmail.com>
 <CAD=hENdqho3mRy=gUSE-vuXzLvZPkwJ7kEFrjRN-AxLwvQP18Q@mail.gmail.com>
 <611CABE6.3010700@fujitsu.com>
 <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
 <611CBA42.9020002@fujitsu.com>
 <CAD=hENcE12nKdRn04K9Zbd1CyOQureYb44fp9occ=R4P6XrgZQ@mail.gmail.com>
 <611D1A3E.20701@fujitsu.com>
 <CAD=hENeYiTrfxDTAS9UkF8tn7=wa49H0DQuCBKeHpd+L6qM4SQ@mail.gmail.com>
 <611F5CD8.2020504@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <3ef95380-ea42-562a-975d-d767d76ee2ca@gmail.com>
Date:   Fri, 20 Aug 2021 16:40:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <611F5CD8.2020504@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/20/21 2:42 AM, yangx.jy@fujitsu.com wrote:
> On 2021/8/20 11:31, Zhu Yanjun wrote:
>> Latest kernel + latest rdma-coOnre<  ------rping---->  5.10.y stable +
>> latest rdma-core
>> Latest kernel + latest rdma-core<  ------rping---->  5.11.y stable +
>> latest rdma-core
>> Latest kernel + latest rdma-core<  ------rping---->  5.12.y stable +
>> latest rdma-core
>> Latest kernel + latest rdma-core<  ------rping---->  5.13.y stable +
>> latest rdma-core
>>
>> The above works well.
> Hi Yanjun,
> 
> Sorry, I don't know why you cannot reproduce the bug.
> 
> Did you see the similar bug reported by Olga Kornievskaia?
> https://www.spinics.net/lists/linux-rdma/msg104358.html
> https://www.spinics.net/lists/linux-rdma/msg104359.html
> https://www.spinics.net/lists/linux-rdma/msg104360.html
> 
> Best Regards,
> Xiao Yang
>> Zhu Yanjun
>>

There is some interest in the current status of rping on rxe.
I have looked at several configurations and tested the following test cases:

	1. The python test suite in rdma-core
	2. ib_xxx_bw and ib_xxx_bw -R for RC
	3. rping

Between the following node configurations.

	A. 5.11.0 (ubuntu 21.04 OOB) + rdma-core 33.1 (ubuntu 21.04 OOB)
	B. 5.11.0 + current rdma-core
		+ "Provider/rxe:Set the correct value of resid for inline data" (a.k.a rdma-core+)
	C. 5.14.0-rc1+ (for-next current)
		+ 5 recent bug fixes (a.k.a. for-next+)
			RDMA/rxe:Fix bug in get srq wqe in rxe_resp.c.patch

			RDMA/rxe:Fix bug in rxe_net.c.patch

			RDMA/rxe:Add memory barriers to kernel queues.patch

			RDMA/rxe:Fix memory allocation while locked.patch

			RDMA/rxe:Zero out index member of struct rxe_queue.patch
		+ rdma-core+
	D. for-next+ + rdma-core (33.1)

Results:
	1.  A N/A
	1.  B no errors, some skips
	1.  C no errors, some skips
	1.  D N/A
	(n.b. requires adding IPV6 address == gid[0] by hand)

	2. [A-D] -> [A-D] all pass

	3.  A -> A, C -> C, D -> D all pass, all other combinations fail

	(RDMA_resolve_route: No such device. Not yet sure cause of failures but looking into it.)
	In theory these should all work but rdmacm is more sensitive to configuration than verbs. 

Bob

