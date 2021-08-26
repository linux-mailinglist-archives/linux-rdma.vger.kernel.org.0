Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB783F910E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 01:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhHZXqf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 19:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhHZXqe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 19:46:34 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8498C061757
        for <linux-rdma@vger.kernel.org>; Thu, 26 Aug 2021 16:45:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m21so5340237qkm.13
        for <linux-rdma@vger.kernel.org>; Thu, 26 Aug 2021 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h95rwMevQgrjwgD8IusJfbAMN++x7kUpyNxQIkWfpu4=;
        b=Jr0RqVQXrVBwg/WplMIISJq6SObpCdm7TlOhvVmQiUCk8Nqlcg8oql467emVnIsJse
         i80uCE8IWRQtLud2b0PhjXXJM18Pga5poJIZL4CLSi+snaeLFZ420gzoyBvAelGB2gu3
         7HPjOFiKfmWBpjP/Vy2XErhFmMGiwkjV7ORlczX58VV4HBFjv1+Wg+TIO3Yrq0wqdPJs
         f4Pg/5FNJDOMXv3tmiXGUJpGvsdMOR9Wb4Q0ttg4y03UUOp1KvCAzpqGVA1R6XfdK3PL
         F0ZTPWhBrWzSwnphAISVVTrG1Z2T+8EY+JgaqPfSEaft+LI780PNt8i9MS9jfiLgLvZu
         ZI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h95rwMevQgrjwgD8IusJfbAMN++x7kUpyNxQIkWfpu4=;
        b=X4dSK9dbrrER+tEbblcIe83JCS+xvlJcv+iC9++uFAwfgcmSZZq5vg/B6k4fu7b3rJ
         glUz98YUR95d9hIvg/6F1MXM9SDQEma8vuys0oarsexroO96AkswqcN8dQD+xarURbOY
         ILL42AAZcs8oL6R/Ve5VwJIvUuW5Pf+M4Mu5r/HMRhBOk+ZvxImCRCa9rHce025BdYX6
         hjQEMZUGjn+oL+iOsW6PXM7JQmrIDRabXtYsi97WJOqx+/fMsxf8/a6KDJm3OMc6BcKn
         Z5GY8tIqVpg84AVi9z3zFxpwZHy1dG3PXmxrGwehjMJMrabjG94g7bsjABpPQyiOGMDM
         MPxg==
X-Gm-Message-State: AOAM530KZWZXTFfWv+xDQGLs2VUiBJwJ+eGFYRbDXDB/LouLhCLz9K8E
        1X1pnWZg4k6Nx3onIBg0fVfUYXoz7knwvQ==
X-Google-Smtp-Source: ABdhPJxyD8pj/CMViWM+7vaIQYmIYlhkCzJpvuUx7N+jBAMeDl/orrJFFPl9W0WColwO2lStcqEV4w==
X-Received: by 2002:a37:6103:: with SMTP id v3mr6551356qkb.12.1630021546046;
        Thu, 26 Aug 2021 16:45:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p125sm3766669qkd.49.2021.08.26.16.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 16:45:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mJP44-005VLQ-N6; Thu, 26 Aug 2021 20:45:44 -0300
Date:   Thu, 26 Aug 2021 20:45:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Subject: Re: IB_MR_TYPE_SG_GAPS support
Message-ID: <20210826234544.GE1200268@ziepe.ca>
References: <D87B6648-A4C4-4D0B-A390-EA1F0A240C08@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D87B6648-A4C4-4D0B-A390-EA1F0A240C08@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 26, 2021 at 05:26:11PM +0000, Chuck Lever III wrote:

> If GPU and CPU pages are not considered contiguous, then some
> additional loop termination logic is needed here so that at
> a boundary between page types, xprtrdma will simply move
> into a fresh MR instead of coalescing.

Upstream Linux does not have support for GPU pages in the RDMA stack.

Jason
