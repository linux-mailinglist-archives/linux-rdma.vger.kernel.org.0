Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4439E6FBBAC
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 01:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjEHX4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 19:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEHX4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 19:56:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925F35A8;
        Mon,  8 May 2023 16:56:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115eef620so38423869b3a.1;
        Mon, 08 May 2023 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590182; x=1686182182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=cm9jDe0t28gHS219SkGfotNMQfDlC6nuVTy2FULrSIAx+R9mCO0e9BA32wPjr87+dk
         n1/o5vBtYYYS5SoGIArtYUAbO3sJXBnlzA0RDIZhwiTF7p9l7jGaCOMpp9tKz4uA7rXK
         eRZNGlcpbc7IOCmVNwbR8kKHx82n2oMDHb/pz8pIrZyN7z502UDTmN3l+NEU+trqkqZw
         A+3Kx0r+ItE1KjIwlkEKvUWhFrrjzStoSM2ItmMpp09XZO2J5O4OZZtO5dSePwgClEan
         Oal5atcjhtH0Mh4hwnXy2/5NDe5VOUgMzuHlTZZpdzXck09FO4odvelLswGoUVUZxZhY
         UHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590182; x=1686182182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=hCtimGDOGEWo+mZ94MJgl5x9d5blcgqrO/FujTboXixolmpyVxl0ylyamHhhv6+Uzk
         Yvd5G2wP7L7g2RYwTx/LeiGdGCDwFhPL9KhY26s1Le0bn1dv07IchBEUFEbyrEPzOibd
         kkGyEiJxpxODg9QnYRaMX4SGXQluoiZ3DXif7ywutTSe1GZL9INrHsHfQgMKee5E1gKd
         5he9uFsT4cu1rPUP4ZbXspMfZ/xfa3dyCLEzrE3Wc/WFXuTu3mq6KDhdhYYdcAFDFuac
         6wbXoDwvjZov9DW523L+gr195awII98Vcu3ZcS+RLnYFh5vrx2F9Emzv2IUJ2GgRJfVf
         ZyQw==
X-Gm-Message-State: AC+VfDyp7qZ/fHsY8NMwknt1gjjAloaFaRUHbT+cfXs7qQEoB644XJOY
        AsHRAVcmNrxfWcJ6CUsUsbY=
X-Google-Smtp-Source: ACHHUZ5oOHMPQySEl2os9W7jiCY8YMUFIsWiV3gucJAeO5Nk0Kwj9/REstVBzsxA6cv7nEbYOR3gOg==
X-Received: by 2002:a17:90a:2f05:b0:250:3652:55bd with SMTP id s5-20020a17090a2f0500b00250365255bdmr13526191pjd.14.1683590182020;
        Mon, 08 May 2023 16:56:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p15-20020a63fe0f000000b00514256c05c2sm64923pgh.7.2023.05.08.16.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:56:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:56:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 03/22] IB/hfi1: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFmMJOdQeku-cND5@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-4-tj@kernel.org>
 <26ff5035-2d70-44a0-6f0e-3e934b0ae8b6@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ff5035-2d70-44a0-6f0e-3e934b0ae8b6@cornelisnetworks.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Applied to wq/for-6.5-cleanup-ordered.

Thanks.

-- 
tejun
