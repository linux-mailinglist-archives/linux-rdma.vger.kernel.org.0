Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48F17E165F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Nov 2023 21:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjKEUTG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Nov 2023 15:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKEUTF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Nov 2023 15:19:05 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EDC90
        for <linux-rdma@vger.kernel.org>; Sun,  5 Nov 2023 12:19:03 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1e98e97c824so2434123fac.1
        for <linux-rdma@vger.kernel.org>; Sun, 05 Nov 2023 12:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699215542; x=1699820342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok40iS372I7EuBxp+PdMgXvF0AA49iDDuOspSwyRa48=;
        b=HW1nvAhMmbwbtHecDFmghqAio+mLK89Wq+6QXib2cn1BMbX3FRIS5rNSUmDij/ZBz4
         SlCbfp82hV0Odv3PXC+blqQ0aU4u2k99j5YbMEQ8okNymOpOHRrF/RbkZSk+hO0QOFWg
         RmnAFY0DH5FYIZ4e80QdUS98ul3tXXi7npoZrJp8IvlhgrI6HuhcsHf6k6cfxafjKwJe
         W7eyOrIWb+6wqzLvS4LXDgri851YtuJUQBYBCAELtoChHSZhLy8jWaPRZZWuMRrhSIWJ
         VxiLrGvRa4fWUO8+2kJXi17GW48et/Ks2l74qb6pKwvtVeM3qMU0EZEDrqEgVSqJQcJE
         G69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699215542; x=1699820342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok40iS372I7EuBxp+PdMgXvF0AA49iDDuOspSwyRa48=;
        b=YlW7lIgf+nkSupRr8+MsP1rXzXtPNtaNFHb4gd6ggC1PaIidsRM1CHLEFTrcWZUqKU
         7dPyR5z4fR3fApF0pLGahMRLBS6JNNF8Q++7rV4RGFf4cxo7zYivCI1Y/AgPNavA0Od0
         eeuiPJanzt6an2J63ViQbdwVR06P3q6VqaAbA2ylCIVCx2gkglX9JsOiBVoHF1qlQ9Ds
         EahCpbsEoHElQaOXVve1Vce7opL8aZI0sEe/qzTnyeGHL2Lq8w0NLRa/yCl93Nj1+LR3
         b7Ppa/GzxZ7ZDLbfeoml/0ddyEzeuoyP3+QTtXMywA+6pLpWl+3aZkc3+FC9VbYlcei0
         IGYg==
X-Gm-Message-State: AOJu0YwdF9WqdNxMxU32ekwrnbnUneouKWKPadf9wFps5iXTpk6mZ1wG
        Shk4Qvjtjuqk24uScbgVtGo=
X-Google-Smtp-Source: AGHT+IH/BIx8yteLcSWMBe38yyENglcF9GmhbCwPEV1zOQQAc8cyQspD0T4ASTiQcJ36sVvJeL6RNQ==
X-Received: by 2002:a05:6870:498a:b0:1dd:4e2:f825 with SMTP id ho10-20020a056870498a00b001dd04e2f825mr5067620oab.8.1699215542498;
        Sun, 05 Nov 2023 12:19:02 -0800 (PST)
Received: from ?IPV6:2603:8081:1405:679b:7d5a:f32b:d7fe:f16c? (2603-8081-1405-679b-7d5a-f32b-d7fe-f16c.res6.spectrum.com. [2603:8081:1405:679b:7d5a:f32b:d7fe:f16c])
        by smtp.gmail.com with ESMTPSA id c5-20020a05687091c500b001dd8c46ed49sm1148649oaf.8.2023.11.05.12.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 12:19:01 -0800 (PST)
Message-ID: <a0b998f6-7c03-466e-b163-3317f7a5576c@gmail.com>
Date:   Sun, 5 Nov 2023 14:19:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Register IP mcast address
To:     Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
 <20231103204324.9606-4-rpearsonhpe@gmail.com>
 <30513a47-68c6-410f-bbfb-09211f07b082@linux.dev>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <30513a47-68c6-410f-bbfb-09211f07b082@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/4/23 07:42, Zhu Yanjun wrote:

> 
> Using reverse fir tree, a.k.a. reverse Christmas tree or reverse XMAS 
> tree, for
> 
> variable declarations isn't strictly required, though it is still 
> preferred.
> 
> Zhu Yanjun
> 
> 
Yeah. I usually follow that style for new code (except if there are
dependencies) but mostly add new variables at the end of the list
together  because it makes the patch simpler to read. At least it
does for me. If you care, I am happy to fix this.

Bob
