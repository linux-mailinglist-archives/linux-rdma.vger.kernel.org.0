Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341801CDAD5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgEKNLk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 09:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKNLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 09:11:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E0C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:11:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j2so7501626qtr.12
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i0mx8SW1zG6cHX5IhIa0IwNHkuzJwI0QfeXmXHFn/w8=;
        b=B4RX62GVSSfreT+aVKGKxBgWZFwpGB05s0cjCG1SVz6nQ/gR5eYNZ5SnLjtAzQVHOM
         N5EmXRgM4HZGKFBO1tU38vaMr2JRtDO7SaFMmhYZT/xcGGEQuCSStexj2Zwz4csTc0tV
         SMw/L+1dSZWH4Hu0lEsT0oUYQdeM1hGXN0QJCRyBtt5f5NT3ehktZk6l2SautTlF0t/p
         dL1nID39i//SWL4Mnv/7A+/JNd50nsmdsSu/93qYGVI939LOlWcAmjb40hxMylUdocaK
         QKOAfIkIDTxIbzKCtcMfEbFs1LBM1wyjG+LwFv4oI9XVKZL8RrFMw+DDFzTaH7V1D50d
         4TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i0mx8SW1zG6cHX5IhIa0IwNHkuzJwI0QfeXmXHFn/w8=;
        b=RnxVYQLX9fXoCi3ETkxOHZwdhCwhHVi1pLNQoDQzoCyKjtmQQ3vv1ZwhsDUlg3IjoQ
         5Uhp/tjAiGv1xcgNnSgx8ma6/GdIH412D+n02Zh5DCcjsy3ccIo5AdKB9AFHxEV5YWvy
         9OnpMfUV1OSp+q4sYPuXck7YKXkcM7eE4OJufpBJbfdPr3EOa+6n4O9q9MZ9/NRs82U5
         wSD2zEGonVeQlLQzyJTtZd8+QkDtbQYWRrJkRk/w76mzAd218Ix62mxtxZw4W4ia06ld
         0oZptchCpB3UkNZgIvHLDaLeymnfguImE9DiD3hSZy8zWBRz2Ah1x97mZm6jO18/UOyi
         bm6A==
X-Gm-Message-State: AGi0PuZf2P5su2skyATaGgpFXq557PVRgP1l9J6VUWgm07AMlxUiG4zx
        VVbI3UWb1BHDkiJMajjrQRBHaA==
X-Google-Smtp-Source: APiQypKn1F8xpk6eUEsOuodLS9od8MqlWUJ8+GaBCnxsPcYXWLfKKc423tohweEVpVahz0qQLWzJbg==
X-Received: by 2002:ac8:7c96:: with SMTP id y22mr15973418qtv.17.1589202697701;
        Mon, 11 May 2020 06:11:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x125sm8211092qke.34.2020.05.11.06.11.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 06:11:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jY8DX-0004ed-Ml; Mon, 11 May 2020 10:11:35 -0300
Date:   Mon, 11 May 2020 10:11:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-rc] RDMA/iw_cxgb4: Fix incorrect function parameters
Message-ID: <20200511131135.GR26002@ziepe.ca>
References: <20200510184157.12466-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510184157.12466-1-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 12:11:57AM +0530, Potnuri Bharat Teja wrote:
> Fixes the incorrect function parameters passed while reading TCB fields and
> completing cached SRQ buffers.

For a -rc fix you must explain what bad thing happens because of the
bug

Jason
