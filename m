Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049171FD480
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 20:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFQSY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgFQSYO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 14:24:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28C7C06174E
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 11:24:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d8so1307615plo.12
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xvbq06xb8rcHDasNPx3O6hTHbslpfoh+riHjhZc++Ks=;
        b=WSLMCKM9ohtqSjMVQAbj8K1EAqWViQgK5qGsYkx3lqhl4SsxwYlRNFiMWoOk2e/+22
         zbFaMYhRiSmM6eMiCRg8pVMnNvBNXK4RWHAEyeSxi1yul8/hoKqqDvYCbK4MJMaUDIp8
         dPW7u7MTXphGIS/lQQK1TTO+1xUR9WezeUktbJn90euKvKx8q2ojaylC5nuI1hd4V9Vh
         wtgE1cx4svZZDf92ll3QVr+I4cvK9FEfJ17p/5L/qNhvs9lrf33cvYerJdTG+R9G5cGw
         v9PZqBGUocA8ZmLvw+z3PCKOn4YYh3CH80/GsBlNE3wl4MqQ/Wk7DLhl0/f5pMepE3sL
         y2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xvbq06xb8rcHDasNPx3O6hTHbslpfoh+riHjhZc++Ks=;
        b=TnHZMVBEcWGQYfz+PzGAa0ibW7FncBiiShyUe5Z/CCeeb7CrXFN2DW+Sxb2efXA4J5
         3B5poKEF+7QnjA5p9gNX5X5acOhDSvpB0l70qygMg7F+9+Oe/DzcH2GDsoOZAzR9PZE9
         mkx+ENBdCGW5Bc3ptIhqGsKHqbx70RjCBmsAffN5gQdd4KNAA5T8IEX9wz6MgqFhHTYp
         5cxC57xBSzkiRBb0CUfTvHKUdsSIOOogcjptEpY04zqbpHUF/1AYDY/UVgmt8DMXoXLb
         AQP8+CU8gfXtWkLGiDTiU3jRgiJTUj/9wM4Ps1Y8Xj9BnG5RqfQcUgpnOWVU43xNf7dK
         cjvw==
X-Gm-Message-State: AOAM531HoTCDsXOWkwbvIyBhJ7UeeiV0G48qIvGLNc6tSJzuuJrEyK2i
        l1zDGrJg1dejRchPkUNTqBUSjQ==
X-Google-Smtp-Source: ABdhPJx+VO5TVkCBs3OrjZcmKB/+bOvx9qgai2d0KOQdclTJeyiQZlq7//E9CmjSCqRbW8mzyMdeUA==
X-Received: by 2002:a17:90a:df0c:: with SMTP id gp12mr363670pjb.148.1592418252950;
        Wed, 17 Jun 2020 11:24:12 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id h8sm516409pfo.67.2020.06.17.11.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:24:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jlcjK-009iJG-KI; Wed, 17 Jun 2020 15:24:10 -0300
Date:   Wed, 17 Jun 2020 15:24:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20200617182410.GK6578@ziepe.ca>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
 <1591627576-920-2-git-send-email-divya.indi@oracle.com>
 <20200609070026.GJ164174@unreal>
 <ee7139ff-465e-6c43-1b55-eab502044e0f@oracle.com>
 <20200614064156.GB2132762@unreal>
 <09bbe749-7eb2-7caa-71a9-3ead4e51e5ed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09bbe749-7eb2-7caa-71a9-3ead4e51e5ed@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 10:56:53AM -0700, Divya Indi wrote:
> The other option might be to use GFP_NOWAIT conditionally ie
> (only use GFP_NOWAIT when GFP_ATOMIC is not specified in gfp_mask else
> use GFP_ATOMIC). Eventual goal being to not have a blocking memory allocation.

This is probably safest for now, unless you can audit all callers and
see if they can switch to GFP_NOWAIT as well

Jason
