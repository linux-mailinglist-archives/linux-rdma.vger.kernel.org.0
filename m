Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C40503747
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Apr 2022 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiDPPWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 16 Apr 2022 11:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiDPPWn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 16 Apr 2022 11:22:43 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D486A21E07
        for <linux-rdma@vger.kernel.org>; Sat, 16 Apr 2022 08:20:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso7091870otj.7
        for <linux-rdma@vger.kernel.org>; Sat, 16 Apr 2022 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=UCmHaEZ6XfLCRUPPKipuXlWB4i1/PdtbjnjCh8ilD5Y=;
        b=jUk+jm0ojL9PWechxU6M/NT3IwPizfx73gnPSVfOm60TQkrwGqzFoPmv+euu6hn4wZ
         wYpPzMp3WzpdymuGAFRJVLpDV1srO9Fw8GTiYfButVPOJ7BczGd7X/EqnE/ENhMGuT4/
         x86lEUyW8a7HsFEhz4TQFlXCtIkmcLGavFStkAo7bDSTWYyhiTYX5Exg7YSMAN1Bzvrv
         pwLh7n1009hnQwVK5QlpSrLRwbrsPdEH2yxJjJu/DUJFhQJCJ7TVPt9xHk0DOADLAFDr
         0JIFI+LE6AnOrBFRcp5eehvSd60agSnfy+guSq4X+rEzJRdaHtXizBHt7VdtARSWX7ZE
         mWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UCmHaEZ6XfLCRUPPKipuXlWB4i1/PdtbjnjCh8ilD5Y=;
        b=OYyhQT5CvCFxXfAg6oMz/L+bT2MhCLyUdgYfS84OivQmUdVD+2fxRa1DKsgAMeGG8L
         pz03aAdNMKNj25aBoAJYazPs67WGNwh2sK1scE5xqF/VqkqXimFrI9Hjb22gncnF/IZT
         EBOPJEiGgwWpAmeHCNcSqPR+bd7//aKMcwLvvZGb/vAJ5Ptw61UYMYzq54Hh3gmvWIyX
         WRqmKZ5soXTtbeUXe0zT0cafDkkT4uEllGX9bnA34IVHkQYXwNsy4JvbgeXpEdOOSVpp
         9HxkwwwOkLWTReDQfZ4xeDmBUtRXc6v1A1sXCMYy0SrRRG6eBIdOcFWsLA3cSXc95/f9
         N0Hg==
X-Gm-Message-State: AOAM530ctLxTWZsdxLqh/bnZ9kTabXJZj6To4wOtnxAqy9YgM20V2XCw
        NgjibzDi76MQdq2BLZ+mJm4=
X-Google-Smtp-Source: ABdhPJzLraM4LRoTRyiTrf03zi5IPcnsz2mR5Ft79z8P84NJn7dSV1ld3hJQEL1H0VdlqA8IrKnPzg==
X-Received: by 2002:a05:6830:22f2:b0:5c4:3f05:33cf with SMTP id t18-20020a05683022f200b005c43f0533cfmr1278804otc.330.1650122404242;
        Sat, 16 Apr 2022 08:20:04 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7fcb:e022:f4df:47d6? (2603-8081-140c-1a00-7fcb-e022-f4df-47d6.res6.spectrum.com. [2603:8081:140c:1a00:7fcb:e022:f4df:47d6])
        by smtp.gmail.com with ESMTPSA id bg37-20020a05680817a500b002fa739a0621sm2192597oib.16.2022.04.16.08.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 08:20:03 -0700 (PDT)
Message-ID: <e46ac7fe-b9be-bbfe-375b-905a86c0e504@gmail.com>
Date:   Sat, 16 Apr 2022 10:20:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Subject: [PATCH for-next] RDMA/rxe: Fix "Soft RoCE
 Driver"
Content-Language: en-US
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220416063312.7777-1-rpearsonhpe@gmail.com>
 <77223356-6762-aa69-1cb3-480b41b45d97@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <77223356-6762-aa69-1cb3-480b41b45d97@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Agreed.
