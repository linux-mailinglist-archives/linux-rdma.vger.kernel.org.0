Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB43C6FBC8B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 03:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEIBfg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 21:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEIBff (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 21:35:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3244494;
        Mon,  8 May 2023 18:35:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51b603bb360so4785060a12.2;
        Mon, 08 May 2023 18:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683596134; x=1686188134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZJgD1ocOPnpZROiNJ9/FVoxk5fPkeLgQmc8oBpVxpw=;
        b=GLKjfNldZXpVLyaNtopZtOmgNNlprLFZLj37Qp1xzcpRjw5XWswxKQmxLPJJfUuJL2
         t6ewEEPxm9sMGHS8aImfY06ZIXxbZGQ4VeDt0SsgcW3eIm1Dat8Q6XINxytGFPq3ZLXR
         pnIYH3CWgUZ3c7ZcJ11ACoYIUv929UpfFM2DH9VKRhrmsA2bHzftyk00qYA9NwcNEcW8
         hRjgEOxMyw0mFTXCpPpAN43Ukj3rWVmvpqBXy4PGJnUlT3xqx7dJgqiOUednkgx1kg0f
         3dGre0z3/8fE4GAAGTzJr3UWxXSi90R2QQELp/MPBC43Wfg+YWfNk3o1fi5yU+/lwnMJ
         xGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683596134; x=1686188134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZJgD1ocOPnpZROiNJ9/FVoxk5fPkeLgQmc8oBpVxpw=;
        b=KcH3g8RD5lvzWkpnTCaHoDBHYyY3GSHRPoJW1H1pcCN1JaFxjF6qUgzq3ydsDYGsTs
         jBK4iyUtdvV0R345xikCGpitUR6XwZN/Y95E0MoVT1DAGq/ICMGS9JMKtDYbqBR3xBJ6
         EZ5NaCknomsRmoQ1OBDcTbVT/9kd7PPu94413DcfktZjuB8fPMBo3BRmUDQB6qsx4u4D
         +Ya2e1IlUQnfwXCkjaCZxVTvH9ES3p1fa7pbSO8pdDG8DhFvqPQ8k7ukqRX+EVCuce3g
         95BPbOWUM2ATfeWQvkuGHXmM+3GuptkDSQfsdwmrnLmyhpdTTF8CzEN7HUuwZkKpJX/3
         Za/Q==
X-Gm-Message-State: AC+VfDwgPMNm5RyNDZoBaGtuh04yVH5VmwyXX9bFJFzTFFtqa6Kiz4LG
        ePMDNj6SnuxJKi67GrHbvCE=
X-Google-Smtp-Source: ACHHUZ7+a/0tfqL4n+TrtmtaR983vl+5RNXkqecpnDYi/x3a3eVD0gAIHqmd6qZYZvNgZAkb7iWVgA==
X-Received: by 2002:a17:903:41ca:b0:1aa:d545:462e with SMTP id u10-20020a17090341ca00b001aad545462emr16664817ple.13.1683596134300;
        Mon, 08 May 2023 18:35:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b001a95680eecesm110022plg.297.2023.05.08.18.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:35:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 15:35:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 03/22] IB/hfi1: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFmjZCtkuit0MHaI@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-4-tj@kernel.org>
 <26ff5035-2d70-44a0-6f0e-3e934b0ae8b6@cornelisnetworks.com>
 <ZFmMJOdQeku-cND5@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFmMJOdQeku-cND5@slm.duckdns.org>
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

On Mon, May 08, 2023 at 01:56:20PM -1000, Tejun Heo wrote:
> Applied to wq/for-6.5-cleanup-ordered.

This has WQ_SYSFS so can't be an ordered workqueue. Sorry, this is a pattern
I missed. Dropped the patch.

Thanks.

-- 
tejun
