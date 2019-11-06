Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30204F1F9F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 21:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfKFURc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 15:17:32 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33666 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFURc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 15:17:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id y39so35188176qty.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRhzInsmolwnzZhSG3fdiEqOKfUFfQ1y+hRjmVdCQGE=;
        b=nvh0lyevWu6kEPFpV0lGZLDF8bfgjhX9NHv3c9aUkRCqnS1mgjCVSiCvrserAeBEa4
         7HcspCUseQhTUC6pWIuz17OwxrVOQvsFkDxwmellpdH2Msx30t0qK36zaN/nOkiD1TFD
         m4yVzwj8biZas2gbAv/kNsIMPiLU3SRZmU9g2FlRpPdYX361xJ4/GDr4Gej8du0soOy6
         393e4KcMvPQZDprpM60OpbDtosuFXDUAqIRqXPZxVndEOWOfZysNCnT8b6TaKnnUpgY9
         JBeGJF9khB8JzJgCu9WKyGhJ8JdR2mppMjJUMqkvSfksThQZgJcMI4r6E6bfkumCDbto
         03Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRhzInsmolwnzZhSG3fdiEqOKfUFfQ1y+hRjmVdCQGE=;
        b=pzD32B8zAPfZp20FMJaismuOlCBgAUavMm0BXmv7SVptrLp0+Cda+8EyXv/Ti0IPI6
         g30Fl72+rE/vK9MtfissfxQoqEYYg6ad46U5NOLApOwOsbCaUj/iQXqVpx25oz1M8S4w
         ng5uyAv0EwfL6enxijGZ/KKnF0SPuQwOYKaXKwp3a9bSGgfA6TZUsTqtTWIGGeKXjaXP
         6GsolUd/omEe0q54ToAFI6zc6Ec6ILDvhkLNFUHyseBChBYcVCBXQutvRW51tgbevYdk
         5WteD2wg1X1yw2x317/p6K8ghO9k85jb3La3K2ncwLaz9stli1rp3o27SHTsHouRDdzM
         wjFQ==
X-Gm-Message-State: APjAAAVIVZc5H2qUu8ecDUO51kzbz3YTwnQu4H8FOOF184YpXahJwf5+
        qDeq/pXZHcFklDujiMODptB8tr74Uak=
X-Google-Smtp-Source: APXvYqwbrY16mOLGL243w8jk/4F4KaAGHE+3avFTceBG1KU3iQuac+e7ax01Olqvfth5ZT9rSf4Qpg==
X-Received: by 2002:ac8:60da:: with SMTP id i26mr4600915qtm.43.1573071451407;
        Wed, 06 Nov 2019 12:17:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p2sm10926404qkf.112.2019.11.06.12.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 12:17:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSRkA-0006jg-1w; Wed, 06 Nov 2019 16:17:30 -0400
Date:   Wed, 6 Nov 2019 16:17:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v4] IB/core: Trace points for diagnosing completion queue
 issues
Message-ID: <20191106201730.GA25804@ziepe.ca>
References: <20191012193714.3336.53797.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012193714.3336.53797.stgit@manet.1015granger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 12, 2019 at 03:42:56PM -0400, Chuck Lever wrote:
> +static int __ib_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
> +{
> +	int rc;
> +
> +	rc = ib_poll_cq(cq, num_entries, wc);
> +	trace_cq_poll(cq, num_entries, rc);
> +	return rc;
> +}

Why not put the trace point in ib_poll_cq directly?

What is the overhead of these things if you don't use them?

Jason
