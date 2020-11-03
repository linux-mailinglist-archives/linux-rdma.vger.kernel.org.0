Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66EC2A37AE
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 01:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKCAWn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 19:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKCAWn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 19:22:43 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A2FC0617A6
        for <linux-rdma@vger.kernel.org>; Mon,  2 Nov 2020 16:22:41 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id g13so7027827qvu.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Nov 2020 16:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h0U8boqn3EBQvT6Kbbxc6BuT59mvexf27LUkicPZNAE=;
        b=U0vQwEt600cnSMm9w+paOrTiSQpPDz7AmXBuVM5UkG3W6yT4VU8+M17QAcMElpAAFG
         uTXhvlzSZBU/TTjlLz1BkwQgYgJtWk8VYFOQeWgqACub0/M04wYrOqH270ytd+hmac8H
         sHTyniUFW+MyFgNZknO/JT2aT5nb9HZuosK19mNGykfnskWgBkT8wS4yGjLO1hFiL/aj
         sHUEcgWwBPksiogB1LPMCn1im76TUsjOUKSjmAELzHlySoxaPnPxv1RHy9JwDdCcdmeB
         h1HPRkZjtLSLr08U0ucBhguQ/WI7Der6dKAtJR4ZWdXiO57MlkcLAeiwUFGzCdprD8WP
         o9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h0U8boqn3EBQvT6Kbbxc6BuT59mvexf27LUkicPZNAE=;
        b=id4mq/bLgYNDASn4lQKx+mCV3gNiES/iQcNhS3ntEkfuEgJEryfhCvaFW3rUT0kxK9
         VhB0HVP3GvtO+vT3w3tyHdRT1h/5KuH+W+Zifr0Nnth7dMQDPujz24aGCUkSFyM2BR+9
         uRfHZAuQJXOhtEq439ruqOfu6bS9U+h33HVVq9muO+uH7ExPUeTsOjKnXFscc4ua0Yw9
         5Tcjgv5uKmSxPmW8VNiAP4P0KN7VGOtPYrly6VfJjt+6MGsOm0PiC6FM/1h+gp7OSInY
         01tKts7gxzivzmVutl0pIYYLQXikE/2xCZDy+216ZvOn1Vja2QjrKzOZASSkOwEJYxAI
         A5EQ==
X-Gm-Message-State: AOAM531vODk3SR1HYtlQ00U0ZXArfDbdZhCxmB/ZMXDxs8y2V631844f
        4ro8hBvbqUp4BRItFDLvBUO+hA==
X-Google-Smtp-Source: ABdhPJxbkjYTENDIS2kuHfzvz3v005IvLS+wx0PhpsgTv9QKoKEbVFJ/bDWvyxbVD2ZTRh5csxuuMg==
X-Received: by 2002:a0c:fb47:: with SMTP id b7mr21067534qvq.25.1604362961120;
        Mon, 02 Nov 2020 16:22:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c12sm9088728qtp.14.2020.11.02.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 16:22:40 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kZk5v-00Fihl-TQ; Mon, 02 Nov 2020 20:22:39 -0400
Date:   Mon, 2 Nov 2020 20:22:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH for-rc v1] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201103002239.GI36674@ziepe.ca>
References: <20201029012243.115730.93867.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029012243.115730.93867.stgit@awfm-01.aw.intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 28, 2020 at 09:22:43PM -0400, Dennis Dalessandro wrote:

> Will add a Cc for stable once the patch is finalized. I'd like to get
> some more feedback on this patch especially in the mmu_interval_notifier
> stuff. 

Which mmu_interval_notifier stuff in this patch?

Can you convert this last usage of mmu_notifier in mmu_rb_handler to
use an interval notifier? I seem to remember thinking it was the right
thing but too complicated for me to attempt

Jason
