Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B161371601
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhECNd5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhECNd4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 09:33:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C653C06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 06:33:03 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 1so3649012qtb.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ra4OfKTrWuvfvsnnvmy7RMlO5oRYrblQvpl+7g9d3P0=;
        b=Y1fNMMZaCd7eVIoZJa2p9nDYcpFo3RCQkjFOfj9IULILafpdc22i5oi9jcAUXqpxPG
         w3wUipXQHcP4kmQ3JKsefDxHUtAeXOlccSiAe1qMeQwGte+e9/MvdMQv9Q74Y4UE8UmL
         QZzWzQAiwPGRRKkLZ2XUt0jwGfKiIW/enQgvfE6KSq6mWZgOtmtTdyc0AJVg5xRNHwgJ
         Pxfx7kfexmYDTjTVDmcEUFdqdpu3IdcM1viomREbngFCHd2eVJc9oCqJXmohzNXp2y4c
         a3Ih83/wxeUuWmNqi+sJMzqXFtnnqITB1Y/fYegW0JI0Gdqq1Y4hS3r+JeDGfmxNca4k
         58oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ra4OfKTrWuvfvsnnvmy7RMlO5oRYrblQvpl+7g9d3P0=;
        b=sfBc+6tbKeGZo8jM3upoWOXjMJmbha0cnIsuwVTItorDnyPFF6gb5CGQ+q8J5Ks1Xs
         skBPi4ueWRkvzhjQqOZYnQr6mORuNGkWeRJL6UR+w2vVFnBpk0j7oT3njW0ax45z2tbo
         rSecAkH3Q/AFtSrfdEofLXhapn3/HxgSrYVMPqriiVkIYbt0KiIEUgjyfhLF5P857p9B
         FreOo9JuNEepweFXo+C8ZbGbrM6FkFfLyFb0kRxNV5TGl0t7+8xkPl4rfkk6e/GjWpKV
         3goS/X3ksSIIm3R7zIBfgV4bxbWC6phUfOXp2/wuDeloPiEH9gFQlDapqCM19e6MuoDW
         aKtw==
X-Gm-Message-State: AOAM531yYJspSYksXsXMfADn3m4NXRJQz4k4lNzX0mmnBeFFighPeMOQ
        cCJzs761az3AejzEeH9PgTBYvvoXDwusZ1mQ
X-Google-Smtp-Source: ABdhPJxWSPtJ+YHB6p0Sf4JfBayFNEuLT5POootHMOshwiCIniN4fox8UKdfex2r1LYBugNTgh0TdA==
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr16951578qtk.122.1620048782222;
        Mon, 03 May 2021 06:33:02 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id l8sm8648652qtv.18.2021.05.03.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 06:33:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ldYh2-00GLLS-An; Mon, 03 May 2021 10:33:00 -0300
Date:   Mon, 3 May 2021 10:33:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [rdma-core 1/4] bnxt_re/lib: fix AH validity check
Message-ID: <20210503133300.GZ2047089@ziepe.ca>
References: <20210503064802.457482-1-devesh.sharma@broadcom.com>
 <20210503064802.457482-2-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503064802.457482-2-devesh.sharma@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 03, 2021 at 12:17:59PM +0530, Devesh Sharma wrote:
> Fixing the AH validity check when initializing the
> UD SQE from AH.
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  providers/bnxt_re/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This all need fixes lines and why do they have such a strange subject?

Jason
