Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57109154AF
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfEFTyQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 15:54:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44967 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFTyQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 15:54:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id w25so2600549qkj.11
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljHBBW/XLuR+HHp3i4N3Peaf7M/pmI+lk0SG9U10V+w=;
        b=J90xAl4tLXBzZYqD7mQeE/QHNLjyCPkdrkUjp4VDfAdB0xpJsEDhocY+tuvQsc7maI
         NnNpJNSw567XT2TvTmchROeP8G7yWIllXPHzFe7oAcNSSpFS+2H/SDscL9ePhhx4JweS
         qaIAq9IXAPJvY6HlCFYVfIMPS7L1q4OvwRN+5ZDBvP+d4ct/TP1mXFXZHmN7ehEcctKk
         6Viukv2IuyNQCe9vkRmInzmoRG5baTvYfxqczwVWbX4RkfylYgNVjBUi58UUd4Qa+1lE
         6IyuZqNCOWgIxtjLvji0wNcnWZfEsZKsFsWtTdiS5n+t3rSE/BkAtNBFRyIbaaA0A2mY
         qShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljHBBW/XLuR+HHp3i4N3Peaf7M/pmI+lk0SG9U10V+w=;
        b=pcMseg6QPyTvm0yFiE6woTydn12lzxY78GdbBsCEtr9CvO5UwEVKy7fYk7H0LnDCmG
         YRFiyFeKtuJdtZRwCF5dtckJcTmaOi9Az0ruuai9W/8iR0GB98UbUTwNX7urxTDBiBHh
         VIfHPOD0NVIZFldZwLoSUxxUn2L1H47s1zxQBtwwys3IV3FPp5OURGLpn4i5M9OQFkxo
         nMC9Qwfs9OJfB2bAVBHWHOsKwcYR22/ApUzdi0wl27S96CjHmVjtfc3gmFkPfOzz/+1M
         zaN5sdYAshf3ZJ0SaJxxwpegEvr1BW45TxjIlanz2F+ETdnWCBcr9zsZWGgjpCIEaacV
         bUrg==
X-Gm-Message-State: APjAAAVEsTtTG/WpdIp2dFa+q/yc0e98yXM6/BrQlUG0kXZkNy3ciDOy
        pSNM9rxuOBrrJTUF62YUqwP5zA==
X-Google-Smtp-Source: APXvYqzfxGrH5GE5PCzxYtDtiillrNNz90Tax8Fod0Lknrk403f91oKBcm+nYqZgV8dQAHbn4Ayv6A==
X-Received: by 2002:a05:620a:1015:: with SMTP id z21mr11740725qkj.229.1557172455622;
        Mon, 06 May 2019 12:54:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g189sm6584497qkd.60.2019.05.06.12.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 12:54:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNjgj-0007pg-Vj; Mon, 06 May 2019 16:54:13 -0300
Date:   Mon, 6 May 2019 16:54:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [RESEND PATCH v2] lib/scatterlist: Remove leftover from
 sg_page_iter comment
Message-ID: <20190506195413.GA30084@ziepe.ca>
References: <1557154976-8070-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557154976-8070-1-git-send-email-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 06:02:56PM +0300, Gal Pressman wrote:
> Commit d901b2760dc6 ("lib/scatterlist: Provide a DMA page iterator")
> added the sg DMA iterator but a leftover remained in the sg_page_iter
> documentation as you cannot get the page dma address (only the page
> itself), fix it.
> 
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> This patch was sent twice to linux-kernel list with no response, I'm sending it
> to the rdma list as that's where the cited patch was sent to.

Okay, applied to for-next thanks

Jason
