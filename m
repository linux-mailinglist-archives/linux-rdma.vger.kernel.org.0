Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3317131CFE7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 19:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPSKa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 13:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhBPSK2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Feb 2021 13:10:28 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF042C061786
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 10:09:47 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v10so7695421qtq.7
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 10:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DWzp1FSnEvawyBPitiHeR9Dh7SZGzIps40QdMtE3Rq0=;
        b=GpPdW7F+ZNBDKGl/04hEFTepYss3OJdR2kiWrX5enTG/SDm+BA1fbeBFSSJ1uDgLBU
         QjrL9YZLui1CzSbX2lAJKuBXJici2yFKBwzI30F/IYWsNxWIXcUk7RAMWQY7xx0ue69c
         lTeaTuykX7785H7LBc9RYXpbQeNoZl4x1KmEyxfcYrrhxQNqbDC/7qLB/xbzv3PmlXOj
         cTWXgRyB5XgLAQKImjSk6DEGDmmUQMo9bJIE0BLCikC7vf03m/+IpOXQQy/OJAquHC5N
         WRNOyfjVLrenkKuXsBdduZh05KblLvyxjGkPGLsXsS5E2yruSeFi8u/s5ioSATPQ9o2s
         +TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DWzp1FSnEvawyBPitiHeR9Dh7SZGzIps40QdMtE3Rq0=;
        b=oOgvQR7hdt74AxCq+mBvpPXwqlhoZsvCNjuYkF8JV66NEkL+JGHLgTyke7nhW+KCWc
         TkSyDaUsFu6t8zrT2b3rdJPlIxxAWQSs2ZY+jiwOFzDkS6F1HMfXps2Lk9eu09I6gZbD
         09EiFLPRPEc6NJwkBjsco987VuXulV+i3cMbZKLlRycjLuCrQ/CBwBBXQRJoIIY+82kf
         +dyLd83ZzrphRA9i23w6q0BFbuDmgZ3JG5Dgf6hZZLHn5FSaOXCRBSLcG/akELAnfVa3
         dUvDx2lzsw6l5dJbPEwzraXCathYHeuRp0nbikTPY5MYVWhQEc6GDENW3oGovk9ztlBf
         43lg==
X-Gm-Message-State: AOAM530jcxv4YAtufSZYrGCOpJ7rKPbBXKPxv1op4p6MFetQ1jMzThPA
        6sp4LcGjjfDXaMlxUU9Hus/z7A==
X-Google-Smtp-Source: ABdhPJwyPfJWLaFNzsfBsjkZMSpwDeU5NnjWyumusIW+uFQTgnpXHy1E28DQhlZ/t2ooJ4YU5J4L5g==
X-Received: by 2002:ac8:a82:: with SMTP id d2mr19609430qti.343.1613498987257;
        Tue, 16 Feb 2021 10:09:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id u20sm14161109qtb.63.2021.02.16.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 10:09:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lC4nC-009EcQ-AT; Tue, 16 Feb 2021 14:09:46 -0400
Date:   Tue, 16 Feb 2021 14:09:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: directing soft iWARP traffic through a secure tunnel
Message-ID: <20210216180946.GV4718@ziepe.ca>
References: <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFA2194C43.CE483827-ON0025867E.004018CA-0025867E.004470FA@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA2194C43.CE483827-ON0025867E.004018CA-0025867E.004470FA@notes.na.collabserv.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 16, 2021 at 12:27:33PM +0000, Bernard Metzler wrote:

> rdma_port_get_link_layer(). Asking the RDMA core experts -
> would a gid of zero have any side effects or bad implications,
> since that ID is by no means unique?

Yeah, it is clearly not ok. Generate a random private GUID?

Jason
