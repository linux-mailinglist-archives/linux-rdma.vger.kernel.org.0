Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B1D2879B5
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgJHQIR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 12:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgJHQIR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 12:08:17 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1973FC0613D2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Oct 2020 09:08:17 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c5so6188213ilr.9
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7vAiZgzedRQgneYNxpF+3yvvihoXnGSCPiWBfj+jb8=;
        b=EMGEVNMppvObjiVu3dSHlNVb+TUZJER2XFdALNp9sy4FrDIoJiMlA7cZhw3+/RBR4X
         otyeN4KNIk7NwgWSpvBYk/e977PJFPNI6oY95omfZeerXJFu4Zs/vfZ4/WB8x9ytjR1E
         GhI/ZQhumkGQzc4wWjtNQyF4eam+Th/LJ8+JTzkneqWppIudq2WmHCjI2O1AL19A7FcK
         l8aOsKbJ241RZiQS55DNYxZ/WRXKpEgENZ2VwdWHCrCgr/TC19PXdl/bezn6aA4lKvGA
         rVjpM2TlZoXpQ2Mxkl5NJmieHZxHHDC9CFM/pc9Hi0hh77Ze0ynZcPgE1siGkEAkGgQk
         5NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K7vAiZgzedRQgneYNxpF+3yvvihoXnGSCPiWBfj+jb8=;
        b=D9YFRQJSfioM8KpAmS9D8jMVdv/hPjeOZ/OYt51IRWkobQq8q0m8JgHT++xlafe8tp
         xDagGhOkVK9wKFOEOsd8XaL3FTljfvJa6XVuQLJlriVksIb40BfAAqQM/rQXkDyAKB/d
         yVdSQi9+IAMzgLlXknIdC+bJCkrBtW6hIUsP92MdBK7VUuFZtvna6sMNCMICyo5/W7w2
         3OwpjvSNoNPD7O998Ccojqoc8H2Tt0J6WRW1VXB+jhi9V8zAEemREvPBYwKvh1M8b7Nu
         0rBjhrV2A1F/oP4h7KT37LrsRbvZeAH6KUfb4XvikAWL1ShO/kuIkCdme5D65Byq7ZVv
         m9sg==
X-Gm-Message-State: AOAM533++UVO1b2hnY7w5ZXqpOLOGeJ0fBZxgOF4lvDa7onqPzbyokYw
        TGzKtcicSV0qFIAiU1QDCAZEEw==
X-Google-Smtp-Source: ABdhPJxQX95dDgdjmWPU0EcyYw77bUg7F8Rz/KmIm22AeOhLDNaCInd5dcZhm78WGmqDw7fW+eouzA==
X-Received: by 2002:a92:cbcf:: with SMTP id s15mr7725725ilq.39.1602173296388;
        Thu, 08 Oct 2020 09:08:16 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id o13sm2360450iop.46.2020.10.08.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 09:08:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQYSk-001XH9-8W; Thu, 08 Oct 2020 13:08:14 -0300
Date:   Thu, 8 Oct 2020 13:08:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201008160814.GF5177@ziepe.ca>
References: <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 07:08:42PM +0800, Ka-Cheong Poon wrote:
> Note that namespace does not really play a role in this "rogue" reasoning.
> The init_net is also a namespace.  The "rogue" reasoning means that no
> kernel module should start a listening RDMA endpoint by itself with or
> without any extra namespaces.  In fact, to conform to this reasoning, the
> "right" thing to do would be to change the code already in upstream to get
> rid of the listening RDMA endpoint in init_net!

Actually I think they all already need user co-ordination?
 
- NFS, user has to setup and load exports
- Storage Targets, user has to setup the target
- IPoIB, user has to set the link up

etc.

Each of those could provide the anchor to learn the namespace.

Jason
