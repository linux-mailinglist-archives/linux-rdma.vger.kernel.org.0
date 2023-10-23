Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF597D3F3A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJWSaB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJWSaA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 14:30:00 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AECD99
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:29:57 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dd8304b980so2610438fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698085796; x=1698690596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xcrOp5J0uumcwsJlger5t42FjfrBozKxY96El3qrCvU=;
        b=mp8zC20XLTz7gdemstakZ/MN2Xtxf5uIxVWPXZc4rGvvey0Yg+D44kctBNN+3WB92B
         0oAf1ymQdtcBOaxfHao+86+LFeAkgl5PWyVJI2z5oGW3rnOIvfICTw3S1h3TOzVW3lzT
         /56FQumW3KB6GXRfh0fRqcyjzrdE5c8R3RA64Bfa+m+VkvD+87IHSP37mxpQ/qtwn5F7
         9xyky4RghJDcFKuuvKHf10qpaTvWj0ZJX5G68SGjZ14LEA4wJ+nsN8SC6coLopYGZ5/O
         E1ais2IGaqIGYcfgml09cp4EzaOnP1tWRnGL96dsJLeCEbm2UluLsg9shA4wlb0i6tLy
         IBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085796; x=1698690596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcrOp5J0uumcwsJlger5t42FjfrBozKxY96El3qrCvU=;
        b=iK2t1mhrqaWAc1EqoJQA7LShqApO9E1irIenDiuDMXlm+WW6GezxL4f/yCF4e7MX8C
         dpz9RJvHCq6LDheINSw7S9KIRk9H7C7IZlVixRNWjuU8gXUsdlLyZTXmztu3HdmjDbxn
         mRi9yGMS2UxXpKjSGc63EzSj4cSvpTnnITY5PjpRVB/ewmcHcACscz7mSxzz1402nQZG
         Mz80+bMFKxewzVtV/IW7qURCb4/HGI/w8MC04hKgcUQ1+GYyxCHwhYkjOo2SocghGHIs
         XxWqhM3CaKBUb/tLTH45waSq4poiZXAguYKll8pTELsHKxwY1EjCLSsC+Z/bMjZprGQq
         5Ueg==
X-Gm-Message-State: AOJu0YwDdYAyDYvKlngLQsYQoonU19rxznBRgDY3tkwE5ExRW/gBrkaN
        VkCeeugZa8dhytinzzWl0xM=
X-Google-Smtp-Source: AGHT+IFg3wQ0gLBNi1K2KTzbGXqAfD12N0OazgDgvyUlqJAzg0jeOebi6OoJDRs2GDPD6cCoHwjrHA==
X-Received: by 2002:a05:6870:ab19:b0:1e9:b496:ce2d with SMTP id gu25-20020a056870ab1900b001e9b496ce2dmr12590981oab.12.1698085796672;
        Mon, 23 Oct 2023 11:29:56 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:60ec:8905:b7b2:5d0f? (2603-8081-1405-679b-60ec-8905-b7b2-5d0f.res6.spectrum.com. [2603:8081:1405:679b:60ec:8905:b7b2:5d0f])
        by smtp.gmail.com with ESMTPSA id v39-20020a056870312700b001dd8c46ed49sm1767465oaa.8.2023.10.23.11.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 11:29:55 -0700 (PDT)
Message-ID: <3e2191b7-56de-4654-936e-46fbc5828122@gmail.com>
Date:   Mon, 23 Oct 2023 13:29:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: srp/002 hang in blktests
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <b549a186-9c80-47e7-a54c-cd64d8cae9b7@gmail.com>
 <06229821-6d93-4f74-95ef-af352f101b7f@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <06229821-6d93-4f74-95ef-af352f101b7f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bart,

Lots of work. Thanks!! Did you mean 6.6 instead of 6.5? I assume
you are running an Ubuntu 23.10 VM and not bare metal while I am
not.

I don't have any ideas either. My hunch is that this issue is very
sensitive to delays. Perhaps our test boxes are a little different
in terms of cpu performance.

I am going to go back to working on rxe per se to try and move some
patches that have been blocked for a long time.

Thanks again,

Bob
