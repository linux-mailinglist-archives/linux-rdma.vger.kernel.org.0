Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F96A286DCB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 06:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgJHEnM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 00:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgJHEnL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 00:43:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB24C061755
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 21:43:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x5so2148793plo.6
        for <linux-rdma@vger.kernel.org>; Wed, 07 Oct 2020 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=8/ymZVWlEDML6foUj4AZDpqnksfZUyUtKHyNOJYE7tw=;
        b=bI/aU9CI6hRbuJ4X1iyK94mWOMeXLC/zMtYQKdjCndFi6i+mQWCS/56TZiJ0e8Lqax
         3WVds7PFye/fpsq1f+ix3lHC1iHPSzoPeSB0J5BVdMVMiM4mxj9KRKkiWXt/RvK1oxqT
         YyD7pGvqwKwMSASB5kw8Vr/Zy4cvZHgvPLzjv5OMkSQw5Z13ptGVdjnIo8ZOYx5+Ip4l
         dnm91Hqq26AvEQhLnEc3qdPZycJELshaYcTUPv8hBU4z0uE2fqcZiOaBfdWj6sPNtauw
         a0JAOfHosKYL42inbwEFvqyg4di37rsoYYpE083/UkETZEAVDiq1NHyoRjgYNrqlByos
         MfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8/ymZVWlEDML6foUj4AZDpqnksfZUyUtKHyNOJYE7tw=;
        b=l1I/ef8upbSYwMYjWaxNPqHyu7Kw2IKrKmwLSbtHYcjMeP2SPr2iQ1K+xco7A6FSqi
         Vmg171ghfhK+3kvhe/L4FLRXBUDAO9HOjx1soynHkS/UA/AI3bfO881i3rIfJMWizpfr
         nDfRoCTN9xtXYJmlJ2AH0Zk7iuanpx4LFfRT6A/oDfy2V0saoGiPh+Q+jMtfPLKyT0lx
         Ohw/sGUMjDXS9whBr7XITuwGhmPrWSEDVvUqaSx29i2h5xRQ1xttuZJ50Ij2WRaZPkFP
         Xd41pViLlwwhqHeCNj1ATHlgPM3Nd8sLItNTsEqKlMgFarlQnJ9X4aM5UpO6cFoMQzY+
         iXUQ==
X-Gm-Message-State: AOAM533/s5z/+5fUdihnaHPj63dnBnasEg6xRr2+HBV50YiaUwXpRaDa
        LVNsd3o45kr/krqRVaUuK8CdkFRGceo=
X-Google-Smtp-Source: ABdhPJyx/u6Zg6raAKNOouQJE1YAp3QBG4CN6XCxfgNZVBuPABTAzK6FIFqYw48/fX10gcxZtv6e9g==
X-Received: by 2002:a17:902:bd48:b029:d2:8ce7:2d4c with SMTP id b8-20020a170902bd48b02900d28ce72d4cmr6060669plx.42.1602132190983;
        Wed, 07 Oct 2020 21:43:10 -0700 (PDT)
Received: from [10.75.201.17] ([129.126.144.50])
        by smtp.gmail.com with ESMTPSA id m5sm4465876pjn.19.2020.10.07.21.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 21:43:10 -0700 (PDT)
Subject: Re: Upcoming OpenFabrics Alliance Webinar
To:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
References: <252007469.52861641.1602078881249.JavaMail.zimbra@redhat.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <0d3afe23-874b-5b9d-b4b0-62d497610d78@gmail.com>
Date:   Thu, 8 Oct 2020 12:43:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <252007469.52861641.1602078881249.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

"Date/Time: Tuesday, October 13, 2020, at 10 a.m. Pacific"

This is Beijing time about 1 am.
Can we record this meeting and share it?

Thanks
Zhu Yanjun

On 10/7/2020 9:54 PM, Doug Ledford wrote:
> Hi all,
>
> Next week at 1pm EDT is a webinar about the new Fabric Software Development Platform (FSDP).  This is a high level presentation about what we are doing.  This is in line with the new testing program we discussed at the 2019 OFA workshop.
>
> I *strongly* encourage any upstream maintainers related to RDMA to attend (that would be kernel maintainers, rdma-core maintainers, libfabric, ucx, openmpi, etc. maintainers).  The FSDP is intended to run CI testing of both upstream kernel and user space projects related to RDMA technologies (it need not be a direct RDMA technology, but one that RDMA interacts with is sufficient to qualify, so NVMe because of NVMEoFabrics is a qualified upstream project for the cluster to run CI on).  As an upstream maintainer, this is your opportunity to see where the cluster design is going and have input into the how the cluster is built.  Keep in mind that hardware has already started to arrive, so this is a case of "speak now, or suck it up".
>
> Also, the cluster is intended to be a place where upstream developers that might have access to limited types of RDMA hardware (Hi Chuck!), but who wish to be able to test across a much broader suite of hardware could log into the cluster and run their tests.  Upstream developers who work for companies that are members of the OFA are automatically qualified for an account on the FSDP.  However, upstream developers working for companies unrelated to RDMA technologies, but who none-the-less end up working on stuff that touches the RDMA stack anyway (Hey HCH!) are also eligible for free individual memberships in the OFA, which grants them eligibility for an account on the FSDP so they too can test their code before sending it.
>
> The presentation next week is fairly high level and does not get too deep into the details of the structure of the FSDP.  This is because the FSDP is just now being built (the first orders for hardware have been placed, servers that control the cluster have been built, now we are starting to build the cluster out) and we still have some flexibility in how things are designed as a result.  This is the upstream community's opportunity to make sure their voice is heard in regards to that design.
>
> I look forward to seeing all of you there, and don't forget to register so we can make sure the webinar is sized sufficiently for the number of attendees.
>
> Doug Ledford
>
>
>
> ------------  Begin forwarded message  ------------------
> New OFA Webinar
> Introduction to OFA’s Fabric Software Development Platform (FSDP)
> October 13 at 10 a.m. Pacific
> One Week Remaining to Register
> http://bit.ly/OFAWebinarFSDP
>
>   
>
> As a reminder, the OpenFabrics Alliance (OFA) will host a webinar highlighting the new Fabric Software Development Platform (FSDP). This webinar is an ideal opportunity for the OFA Community to learn about the new FSDP program, the FSDP Working Group charter and target objectives, which was highlighted in recent a recent OFA blog series (Part 1, Part 2).
>
> Date/Time: Tuesday, October 13, 2020, at 10 a.m. Pacific
>
> Registration:  http://bit.ly/OFAWebinarFSDP
>
> Presenters: OFA FSDP Co-Chairs Tatyana Nikolova of Intel Corporation and Doug Ledford of Red Hat, Inc.
>
> Title: Introduction to OFA’s Fabric Software Development Platform (FSDP)
>
> About: The new Fabric Software Development Platform (FSDP) project is a vendor-neutral cluster owned and maintained by the OFA for the benefit of its members to develop, test, and validate new and existing network technologies. FSDP offers OFA members an opportunity for serious cost reduction in testing, validation, and development, and provides an invaluable service to the open source community of maintainers as they support open source networking software integration.
>
> In this webinar, OFA FSDP Co-Chairs Tatyana Nikolova of Intel Corporation and Doug Ledford of Red Hat, Inc. will cover:
>
>      Origins of FSDP Project
>      Introduction to FSDP Usages
>          Continuous Integration Testing Service
>          On-Demand Development and Testing Program
>          Logo Testing
>      How to Join / Contribute
>
> Please contact press@openfabrics.org with any questions.
>
>

