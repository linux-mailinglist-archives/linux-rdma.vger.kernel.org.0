Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A822C6642
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 14:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgK0NGV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 08:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgK0NGV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 08:06:21 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8635EC0613D1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Nov 2020 05:06:19 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id cv2so2249701qvb.9
        for <linux-rdma@vger.kernel.org>; Fri, 27 Nov 2020 05:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LO3EsDTeAKWTGXo2YsDbNijBZ7GT3knSApI/s3TLwHY=;
        b=Gtu827c93e07ptKxA66BNacsv3XJPonCMbBHNhdNiE1eSrePbmVLeuHMUdhxKG75nS
         ZuRd7fLFl+Rsp9a9NPOnMl1fTZ+J2fwXRzXgsiizzr8r3/Mf1r0+HOvXcrRR8znYRUrC
         fVQtAvyOCv4Kgd04pRl1FLKpdVdtG2sdl9bboeAikH9asV+acQ+FgLdweq38EtAnNzsw
         0yRKTEQkO2Km9JP8KL0zmI3EHj/WSEiAuYivqbrfNahYsxS/U9hIyhK2mMvLsZ9k6jkn
         9rPPae/XjzuE6RHdT+7Hc7Tw/yvPbWs3jXMu6ErhWzVvqZZCFF+tNXx3aNJP7WdDYrfa
         bYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LO3EsDTeAKWTGXo2YsDbNijBZ7GT3knSApI/s3TLwHY=;
        b=aDyCNkkMCXrSnoQZ93ltMGsdoUl1869R3IeiNUma3xTLnk/BsSIIew38CZa1mXZoQg
         gE+a4SmEOSfrnAVlBrDNNY2VSwBaXJ7JEryzLoHQPGDm9B32Mo0uP9Z088y3rhwYdKRo
         3fbc+y3KcaQUqxZfPdlA0BJs54j4x2G+nHqosbl0bkBVxT4bqlhZ9YOaDWLvXrGI7nJ4
         nEfMYf7bt8YFHv4biUbBiAM1vhIvUsiznR9E7qKKTd13YpH1uttidIAHj05h5JJ4vsXP
         NlhJCkAbqfPxKShMpBX8masR4+tQK5LWasN54EjrJsz1ceWkR6wwytt0utnfjntLFgv6
         03ew==
X-Gm-Message-State: AOAM532epPRNEGZoEd5x/v98pNpS3ZpG8fAUhQRZe6n3nPX5ZaB9Az/6
        j5SFsgtRVXpSs6UY+C5spdrZOpnH9HIPWSNI
X-Google-Smtp-Source: ABdhPJzeV7CvKldDuWhDimVjL/XQshnGMPxUMTH2qwzRAn3OLVDskNtlWxyPPBzfMATVZ+lPH7Q6mg==
X-Received: by 2002:a0c:b5a6:: with SMTP id g38mr8144449qve.31.1606482378720;
        Fri, 27 Nov 2020 05:06:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id i84sm5866630qke.33.2020.11.27.05.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:06:17 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kidS5-002XbR-91; Fri, 27 Nov 2020 09:06:17 -0400
Date:   Fri, 27 Nov 2020 09:06:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alok Prasad <palok@marvell.com>
Cc:     dledford@redhat.com, michal.kalderon@marvell.com,
        ariel.elior@marvell.com, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>
Subject: Re: [PATCH for-rc] RDMA/qedr: iWARP invalid(zero) doorbell address
 fix.
Message-ID: <20201127130617.GW5487@ziepe.ca>
References: <20201127090832.11191-1-palok@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127090832.11191-1-palok@marvell.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 27, 2020 at 09:08:32AM +0000, Alok Prasad wrote:
> This patch fixes issue introduced by a previous commit
> where iWARP doorbell address wasn't initialized, causing
> call trace when any RDMA application wants to use this
> interface.

Include the call trace in the commit message

Jason
