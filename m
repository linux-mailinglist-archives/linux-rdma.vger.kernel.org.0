Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA7D79F32C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Sep 2023 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjIMUu1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Sep 2023 16:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjIMUu1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Sep 2023 16:50:27 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B751BCC
        for <linux-rdma@vger.kernel.org>; Wed, 13 Sep 2023 13:50:23 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57129417cecso164245eaf.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 Sep 2023 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694638222; x=1695243022; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aguaN+51WdZDPVACohdDTe5C+B/dDrAUqoUh7FBR6W8=;
        b=jKNiH9IgKOHOHyX5JAft+K8O3G8FHQxhhiAv6RJjvBXBdIMAhMxvq4j11Bot/6Ruae
         HA2vQzCFfE2wagNd7qb9n7+ySYZTSheoGI3Qm3R4VL6jNrbyXvxLFSw0mlS2OPMA55JT
         R83uIMhJRbzUNh5Uyp/4TkqyWGPu5lsJ457dNCGLYT0d1AyjS5AcJPiBfOIoqnffZG+b
         INhGJEaHlR93MXurrfugbHRGkjZ3dbBYyVBJdVbNM/nqhtCVBzEqBmDa5Y28l9cJEV3q
         lytw/e01CzebnUFBwboIi1Jizrrj3YH2FGsnl5PLtpbE8Oy6TYMbN9mgaM93XyJf6Kwm
         uGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694638222; x=1695243022;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aguaN+51WdZDPVACohdDTe5C+B/dDrAUqoUh7FBR6W8=;
        b=VN3eB1uRwJm5/zS1iBviqLDCMILRlKN2zf6qLgLC4+PWkcAdJ4cHbyZfpqAUxv02Z6
         297rsdYgoeofzNuLnaT27e+X2Ty2jhLMsjygoh1t5ATMcqfykVlkkmMt9k8fc3+d357Z
         4SsV8BD3XFux/lsiGhug/p2C8X2/1vZrBLRxvSZI7y221L59Z7t3w7sp54yi0IQscHCi
         pJXnMqx0svz3ILtbCVtT8Bdz30dQ+oLHO1flcePkPbL63KLePHWqYK+SidLquUPgS2rw
         nTZxub7ozJf10ralN3GtqE5bq1VqGdRiUjRyqRK+FtPxxedLAII4aVc5uSXSs0gUd+pJ
         MnMg==
X-Gm-Message-State: AOJu0Yz142HOeAe/Y5UptndQG/MnnXMPNDG8i4aIk0kHSRrD04f0ykaB
        40GMq3M8Mr1kJW5lnzRh6AY=
X-Google-Smtp-Source: AGHT+IGaLu8NgJq8VG7N8cE70fTTySBFJIMlYSfXWCHnCpaykPVRgyU8C3YNCye4C8NpDzp8qhIh8w==
X-Received: by 2002:a4a:919c:0:b0:571:aceb:26d3 with SMTP id d28-20020a4a919c000000b00571aceb26d3mr2520118ooh.4.1694638222531;
        Wed, 13 Sep 2023 13:50:22 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:3305:65ce:78cc:72fb? (2603-8081-1405-679b-3305-65ce-78cc-72fb.res6.spectrum.com. [2603:8081:1405:679b:3305:65ce:78cc:72fb])
        by smtp.gmail.com with ESMTPSA id v20-20020a4ae6d4000000b00565d41ba4d0sm4635807oot.35.2023.09.13.13.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 13:50:22 -0700 (PDT)
Message-ID: <1fbe7ebb-6501-10c4-b9eb-8435661f6046@gmail.com>
Date:   Wed, 13 Sep 2023 15:50:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: newlines in message macros
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Li,

I see that you removed the built-in newlines in the debug macros in rxe.h which is ok by me. But,
for some reason the rxe_xxx() macros all still have built-in newlines. Why shouldn't we be consistent
and make them all the same. (Maybe they don't get used much or at all.)

Bob
