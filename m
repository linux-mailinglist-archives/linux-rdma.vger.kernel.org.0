Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A64243B7D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Aug 2020 16:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMOYX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Aug 2020 10:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHMOYW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Aug 2020 10:24:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C4CC061757
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 07:24:22 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v6so4868725ota.13
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JqsVzo7UiZOVQXjiU3LdgWL1On6klt8nZ8pI9SbRFmM=;
        b=Y8OOQ61IyFwMWg/0aj4K4w6q//5rAFaK8m68wRhUH9mzKJQoxEsX23FdaJV3r77AP4
         25rIvhqNqhirruS+b+Eyws4w37TNvyUaXEVlwZLGBqjyF0DVt9P8m7Vt3qDkN8Vu80R5
         hekc9WpuSzaRH5kSMRg4RRAC7hVZy+IiTBa/VSlugs5b0Mb6VL9E+jbkNS0iV4NlOFLv
         GMSKaeu4W17S8X+PALc9N6ioJhpnA129FOEx1jUeMR7nP0EMzvfOzufirQLokSsHuVu/
         31dJiKkmx6k1+NOvPBmOQmuiXFesgZ6X62obE8KLJFTlKcCjcONXKuSL2dbyKVVwkpG2
         GCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JqsVzo7UiZOVQXjiU3LdgWL1On6klt8nZ8pI9SbRFmM=;
        b=bQxuwSxAbAIcqnjeXG0pFdCb5iZWp//FMg2hjERrJVkqi3RQVkq2k6448s6//Nvxu1
         QlsuI8f+MCg+Z4xedE5TH/IACHGb7Uuwdzo0TIVCfa3vRN5BBwfODSazO83t09lvFX3t
         wQMUAZeyOmoSUpti/ZPwc/60NjUFphdE+tv/TsoJTN6cZ9c8jhyt2HrU2VoQvanmOAvQ
         0zFfh+MBD5QXT2r9KiKMH+Gd9m/K+VviKqWY/l0mI6v1sWqdUAo1La/kreAxo3r973J5
         fnYYJwiTG6m7SMDjopkhnrpeoxvOm4YVQnMAotC+KHWdwA/1BXMc1OUzwvxexVtXiNDa
         GQDQ==
X-Gm-Message-State: AOAM533A2Cd2BdDeI9C1elxLunBObn7sBbXUmDQOoEO8zz6oyrQohJ8L
        JUnhhQuXWOsIDEye8DG2u7k=
X-Google-Smtp-Source: ABdhPJzuA7UMmtj5H8dzTDn9qdhTYXy71/RCZrav/a6V2EYkusJSg6pA5L3rHRtcB1xUntOV9o8zEQ==
X-Received: by 2002:a9d:66c5:: with SMTP id t5mr4628273otm.209.1597328661607;
        Thu, 13 Aug 2020 07:24:21 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:d46:5113:64d8:597c? ([2605:6000:8b03:f000:d46:5113:64d8:597c])
        by smtp.gmail.com with ESMTPSA id o3sm1129365oom.26.2020.08.13.07.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:24:21 -0700 (PDT)
Subject: Re: [PATCH 1/1] Address an issue with hardened user copy
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com,
        Bob Pearson <rpearson@hpe.com>
References: <20200811191457.6309-1-rpearson@hpe.com>
 <20200812055255.GI634816@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <38325e36-ff29-d75e-6d90-89168a6062ab@gmail.com>
Date:   Thu, 13 Aug 2020 09:24:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812055255.GI634816@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/12/20 12:52 AM, Leon Romanovsky wrote:
> On Tue, Aug 11, 2020 at 02:14:57PM -0500, Bob Pearson wrote:
>> by copying to user space from the stack instead of slab cache.
>> This affects the rdma_rxe driver causing a warning once per boot.
>> The alternative is to ifigure out how to whitelist the xxx_qp struct
> 
> ifigure -> figure
> 
>> but this seems simple and clean.
> 
> 
> We have multiple cases like this in the code, what is the error exactly?
> And what is "hardened user copy"?

read https://lwn.net/Articles/727322/

