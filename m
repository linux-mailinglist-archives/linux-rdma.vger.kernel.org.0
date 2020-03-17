Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1251891DE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 00:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQXRB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 19:17:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37561 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgCQXRB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 19:17:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id z25so30831313qkj.4
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LB4pCz7NEbRMB83euBhr3RVL0Fqj77HwZfHrDfDCdiQ=;
        b=C0uBIWqj5EaxcjO6dalveC+LmhDoxFluP96+Jf0sbDmu0Iv5W37mRR9qTDIRcdLq6+
         EOOrYg5AUDam0PdrzNPUH52tnL3J2aRqOcfn1cggkgrfGDPAKCc/n3r8ttLB3xN6v5eA
         QKZobAs71LImwocY6ryR11cMDkX/G0U0MCL7HT8D/if87nQxS4Aq2+acOyS2rz9ue/F9
         RQTxemlm/JRX94n2De3AOY2IBjQ4c3sYwDMsCyEXkkQVFxr05TbqLNHdI7DRIiY7BFnY
         UxH6sUsIHABQYGni+apjEQaJ7ln5wlgK0UTpX2C7d067OZPgDUyBqXuhxutIGfaPRfN5
         dFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LB4pCz7NEbRMB83euBhr3RVL0Fqj77HwZfHrDfDCdiQ=;
        b=Mf2v8IEeMfecYeMRnI9rwMZnzk8wI3sNcwkx/8vXVUMtFRtcpacRDjwGCDivuH8Fly
         sH3mO4Rdn55Oq049zfW9VMgFt24Pj12h2/nQM6XveOsvOFVOph5UhD21q7fX/oUDa8xo
         t9UYqB1gBr1xIYW19dfsw67OaRG1sLoD/cKiYlGEBVvo6sGc9WETXCJT7V5zCljaKH5v
         Sj5gW3jUn5aM7tJXNEgfqKl/kpAo5G99CGTfQll5NXRgjhMj1fgpogVtWk/RN7lr17qo
         Tdi/Ij7niUuI4LgI2CpwbWodr1umeOwb6ogCUlKCynD/8G82GZ+Yb9L+H9OMz9aJNggP
         SHCQ==
X-Gm-Message-State: ANhLgQ2D6wiIx7bFdADgVU7AxNEYOUYJldB0tiRos9Ya7DXSXjo0cDRc
        nhJz2UDWVqYeHplBqTWOJmUzgA==
X-Google-Smtp-Source: ADFU+vt6EAbPKD7F8Ju38mYNMSluIA8LDk42gievwM7V3Dvh+V+HaPi+p5Ehv749O8sqHwTNbQSGnw==
X-Received: by 2002:a37:7a04:: with SMTP id v4mr1425486qkc.246.1584487019946;
        Tue, 17 Mar 2020 16:16:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j50sm3455076qta.42.2020.03.17.16.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 16:16:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jELSE-00019P-TI; Tue, 17 Mar 2020 20:16:58 -0300
Date:   Tue, 17 Mar 2020 20:16:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 for-next 0/3] RDMA/bnxt_re: Fixes for handling device
 references
Message-ID: <20200317231658.GA4390@ziepe.ca>
References: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 09:33:24AM -0700, Selvin Xavier wrote:
> Avoid the driver's internal mechanisms to check
> for device registered state and counting the work queue
> scheduling.
> 
> v1-> v2:
>   - Removed all reference of BNXT_RE_FLAG_IBDEV_REGISTERED
>     from patch 1
>   - Removed smp_mb__before_atomic call from patch 3
> 
> Jason Gunthorpe (2):
>   RDMA/bnxt_re: Use ib_device_try_get()
>   RDMA/bnxt_re: Fix lifetimes in bnxt_re_task
> 
> Selvin Xavier (1):
>   RDMA/bnxt_re: Remove unnecessary sched count

Applied to for-next, thanks

Jason
