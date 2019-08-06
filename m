Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4868982F21
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbfHFJ4n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 05:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732290AbfHFJ4m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 05:56:42 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 378D820651;
        Tue,  6 Aug 2019 09:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565085401;
        bh=cQfjyGK4iEIDPaPVEhWiX1KCBH/i1T1WaBm1tnYzE+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHpfXv9CaBjNm7wf/qy+lOjwZ3jtUKBrSDUMNAD8XYZgJVI3XTB1LZgOYhIZxrF8+
         +xYFNXC+GRI6naBtes5EeZW1BkMR6Tb0sWGl/AfVUFVcReT2fcZ3x7h/pE6R3Ej/sv
         UhH5qppgqfvAl9uSmEIT/VI/w12RtoE/x/5jCs70=
Date:   Tue, 6 Aug 2019 12:56:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Subject: Re: [PATCH for-next V3 1/4] RDMA: Introduce ib_port_phys_state enum
Message-ID: <20190806095638.GU4832@mtr-leonro.mtl.com>
References: <20190802093210.5705-1-kamalheib1@gmail.com>
 <20190802093210.5705-2-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802093210.5705-2-kamalheib1@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 02, 2019 at 12:32:07PM +0300, Kamal Heib wrote:
> In order to improve readability, add ib_port_phys_state enum to replace
> the use of magic numbers.
>
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Andrew Boyer <aboyer@tobark.org>
> ---
>  drivers/infiniband/core/sysfs.c              | 24 +++++++++++++-------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 ++--
>  drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h  | 10 --------
>  drivers/infiniband/hw/hns/hns_roce_main.c    |  3 ++-
>  drivers/infiniband/hw/mlx4/main.c            |  3 ++-
>  drivers/infiniband/hw/mlx5/main.c            |  4 ++--
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 ++--
>  drivers/infiniband/hw/qedr/verbs.c           |  4 ++--
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +++---
>  drivers/infiniband/sw/rxe/rxe.h              |  4 ----
>  drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 ++---
>  drivers/infiniband/sw/siw/siw_verbs.c        |  3 ++-
>  include/rdma/ib_verbs.h                      | 10 ++++++++
>  15 files changed, 49 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index b477295a96c2..46722e04f6e1 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -301,14 +301,22 @@ static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
>  		return ret;
>
>  	switch (attr.phys_state) {
> -	case 1:  return sprintf(buf, "1: Sleep\n");
> -	case 2:  return sprintf(buf, "2: Polling\n");
> -	case 3:  return sprintf(buf, "3: Disabled\n");
> -	case 4:  return sprintf(buf, "4: PortConfigurationTraining\n");
> -	case 5:  return sprintf(buf, "5: LinkUp\n");
> -	case 6:  return sprintf(buf, "6: LinkErrorRecovery\n");
> -	case 7:  return sprintf(buf, "7: Phy Test\n");
> -	default: return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
> +	case IB_PORT_PHYS_STATE_SLEEP:
> +		return sprintf(buf, "1: Sleep\n");
> +	case IB_PORT_PHYS_STATE_POLLING:
> +		return sprintf(buf, "2: Polling\n");
> +	case IB_PORT_PHYS_STATE_DISABLED:
> +		return sprintf(buf, "3: Disabled\n");
> +	case IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING:
> +		return sprintf(buf, "4: PortConfigurationTraining\n");
> +	case IB_PORT_PHYS_STATE_LINK_UP:
> +		return sprintf(buf, "5: LinkUp\n");
> +	case IB_PORT_PHYS_STATE_LINK_ERROR_RECOVERY:
> +		return sprintf(buf, "6: LinkErrorRecovery\n");
> +	case IB_PORT_PHYS_STATE_PHY_TEST:
> +		return sprintf(buf, "7: Phy Test\n");
> +	default:
> +		return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
>  	}

If you touch that function, the better way to write it will be like here (without OPA)
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/rdma/link.c#n209

sprintf(buf, "%d: %s\n", attr.phys_state, phys_state_to_str(attr.phys_state));

Thanks
