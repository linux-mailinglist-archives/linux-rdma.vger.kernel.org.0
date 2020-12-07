Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395A72D1E3C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 00:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLGXUh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 18:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgLGXUh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Dec 2020 18:20:37 -0500
Date:   Mon, 7 Dec 2020 17:19:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607383196;
        bh=Z9UfPhDcCqOPytbQbnes91S9O1pdSihp8OqIykyElKI=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=feKrf7cKHxvhybY2y29Mb+73AP11CafAE4e0GMKvicue80oF1o+NhKO3MstK+y8vP
         aERQDBrZYfzJZC8vH3nXRjpdyzaoKBPH120uF8xjKvOPW/BF1K9zlx/FrUxs4TMInD
         M4XwsVIR1CcrfKBT5L5jMBoM/q08aB6wpanxlrukmEQrYnKYpLi2alj8K5HMD8re91
         dL/YFikZZQz6Z0nGTDRrROj981hG2xwlhznY+7zFQCARun7ChZrvIiMhOivM0sy4VR
         9cikdgOBwU+/Bpultlejc/ugYxPBxiPSWo+iAecJ/XAM4nomREPTtX3G1CgkjiDcaX
         iW42OZgcl4w5w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] drivers: infiniband: save return value of
 pci_find_capability() in u8
Message-ID: <20201207231954.GA2311330@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206195120.18413-1-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 07, 2020 at 01:21:20AM +0530, Puranjay Mohan wrote:
> Callers of pci_find_capability should save the return value in u8.
> change type of variables from int to u8 to match the specification.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  drivers/infiniband/hw/mthca/mthca_reset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c b/drivers/infiniband/hw/mthca/mthca_reset.c
> index 2a6979e4ae1c..1b6ec870bd47 100644
> --- a/drivers/infiniband/hw/mthca/mthca_reset.c
> +++ b/drivers/infiniband/hw/mthca/mthca_reset.c
> @@ -45,9 +45,9 @@ int mthca_reset(struct mthca_dev *mdev)
>  	u32 *hca_header    = NULL;
>  	u32 *bridge_header = NULL;
>  	struct pci_dev *bridge = NULL;
> -	int bridge_pcix_cap = 0;
> +	u8 bridge_pcix_cap = 0;
>  	int hca_pcie_cap = 0;
> -	int hca_pcix_cap = 0;
> +	u8 hca_pcix_cap = 0;

I don't think this is really worth changing.  That mthca_reset() path
is such a mess that this is the least of the worries there.  This
patch shouldn't have any risk, but I wouldn't want my fingerprints on
that function in case somebody else looks at it later ;-)

>  	u16 devctl;
>  	u16 linkctl;
> -- 
> 2.27.0
> 
