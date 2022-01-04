Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C65483D44
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 08:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiADHyJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 02:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiADHyI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 02:54:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDBAC061761;
        Mon,  3 Jan 2022 23:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7JZR+ofc7UyFvHZxU4JrzGD3GHSK3kyHHLrc9YPopOI=; b=tMXyiyDU6sYA0CpXrn6aG1N7e7
        6Aq2CSPnFwG0IdHlKvZzLnbQXhfuA4sB4iK6cS2mHrJgzJNbwkbDM5rE7zl+ii6o09//KJoqa/AdV
        UbQptxz4X91o3uMj9GsGrYneSuC9pl/D/vXYA3DCJo8gjJfPSXYgBygqTbq4hhpS4GEXOPGyPyNtu
        zKezFvz9N11ZQKKWYyh1MD/nvFDUuZvW6fCtqBt/HSzWf8/1WmugmC1jnFMDTstOETWhsf/7nHxkC
        3WH6Th04blAtpaOIATs51YuVenYejLs2dAH7/pEO6QSmnOG708/4P39Ftb0Y2aibhZLSon6Byqf6N
        4YrrAM0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4edx-00AZQe-0S; Tue, 04 Jan 2022 07:54:05 +0000
Date:   Mon, 3 Jan 2022 23:54:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH v2] RDMA/rxe: Get rid of redundant plus
Message-ID: <YdP9HHjeA8WPiBvf@infradead.org>
References: <20220104012406.27580-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104012406.27580-1-lizhijian@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 04, 2022 at 09:24:06AM +0800, Li Zhijian wrote:
> --- a/drivers/infiniband/sw/rxe/rxe_opcode.c
> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
> @@ -879,9 +879,9 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
>  			[RXE_ATMETH]	= RXE_BTH_BYTES
>  						+ RXE_RDETH_BYTES
>  						+ RXE_DETH_BYTES,
> -			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
> +			[RXE_PAYLOAD]	= RXE_BTH_BYTES
>  						+ RXE_ATMETH_BYTES
> -						+ RXE_DETH_BYTES +
> +						+ RXE_DETH_BYTES
>  						+ RXE_RDETH_BYTES,
>  		}
>  	},
> @@ -900,9 +900,9 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
>  			[RXE_ATMETH]	= RXE_BTH_BYTES
>  						+ RXE_RDETH_BYTES
>  						+ RXE_DETH_BYTES,
> -			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
> +			[RXE_PAYLOAD]	= RXE_BTH_BYTES
>  						+ RXE_ATMETH_BYTES
> -						+ RXE_DETH_BYTES +
> +						+ RXE_DETH_BYTES
>  						+ RXE_RDETH_BYTES,
>  		}
>  	},

Please fix this up to always have the + on the continuing line which
is the normal kernel style.
