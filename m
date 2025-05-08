Return-Path: <linux-rdma+bounces-10155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C752CAAF6F8
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 11:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA58E3ADA0F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C05264FB8;
	Thu,  8 May 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J+KqvhBk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6F263F4E;
	Thu,  8 May 2025 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697433; cv=none; b=dNxEqiAT+tMEZbpzl7N4QeqrDUGqGCWeRSeRd2hnfXfaofdTZ8BU4tEkXZfadwQG3k9rfLLguM4mJ6mKFzp3+E+uMQN4ht83D6ELagKsPuttAb5kMpCb99MXvG7cHlxbXkKpvG+vB/FaVwf+/BOglhQxNzG80qAUKzhhrVYbdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697433; c=relaxed/simple;
	bh=H/WhQNKlzogJE4QdmSUmR0gkiVXIC0GbzPbzBw7pZ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG4OsLfotsQplrwGWo2evWiQrAxULMo7X0qGDoTLnuxu1EGCbP+gRE0FfkEeR2875QvsZKSopQIoruMXJ2Ai/twRzLgddxuwvitlUCwtBUR/rQSCxl0wXwljCWRGRZLLDjSXZeZMDcMIc0r2J2hahdirBvjX5JiQqw4/BJvRDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J+KqvhBk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 382CD21199E0; Thu,  8 May 2025 02:43:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 382CD21199E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746697431;
	bh=T55MVOVWe61rHi3lJfC1UHDy1Z+yOeyzZCnQiMX1Uo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+KqvhBkERu+CQQma0RImBsW5LhVreeG9YYNffcEWSycBij+lh93WmlyNcF60pvxY
	 5jBHglrAgT/MZ2QfE7n74bZ+Il6OEFOcm+jODe3kV8EbPDgU4U1/ggwjXDqA8w2hvf
	 yulekqL+wc8ni0Xqki+vOAWIXEeX4rD6Ax8zRHSQ=
Date: Thu, 8 May 2025 02:43:51 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	hawk@kernel.org, tglx@linutronix.de, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Add handler for hardware servicing
 events
Message-ID: <20250508094351.GA8528@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746633519-17549-1-git-send-email-haiyangz@microsoft.com>
 <20250508092924.GA2081@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508092924.GA2081@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 08, 2025 at 02:29:24AM -0700, Shradha Gupta wrote:
> On Wed, May 07, 2025 at 08:58:39AM -0700, Haiyang Zhang wrote:
> > To collaborate with hardware servicing events, upon receiving the special
> > EQE notification from the HW channel, remove the devices on this bus.
> > Then, after a waiting period based on the device specs, rescan the parent
> > bus to recover the devices.
> > 
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 61 +++++++++++++++++++
> >  include/net/mana/gdma.h                       |  5 +-
> >  2 files changed, 65 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 4ffaf7588885..aa2ccf4d0ec6 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -352,11 +352,52 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
> >  }
> >  EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
> >  
> > +#define MANA_SERVICE_PERIOD 10
> > +
> > +struct mana_serv_work {
> > +	struct work_struct serv_work;
> > +	struct pci_dev *pdev;
> > +};
> > +
> > +static void mana_serv_func(struct work_struct *w)
> > +{
> > +	struct mana_serv_work *mns_wk = container_of(w, struct mana_serv_work, serv_work);
> > +	struct pci_dev *pdev = mns_wk->pdev;
> > +	struct pci_bus *bus, *parent;
> > +
> > +	if (!pdev)
> > +		goto out;
> > +
> > +	bus = pdev->bus;
> > +	if (!bus) {
> > +		dev_err(&pdev->dev, "MANA service: no bus\n");
> > +		goto out;
> > +	}
> > +
> > +	parent = bus->parent;
> > +	if (!parent) {
> > +		dev_err(&pdev->dev, "MANA service: no parent bus\n");
> > +		goto out;
> > +	}
> > +
> > +	pci_stop_and_remove_bus_device_locked(bus->self);
> > +
> > +	msleep(MANA_SERVICE_PERIOD * 1000);
> > +
> > +	pci_lock_rescan_remove();
> > +	pci_rescan_bus(parent);
> > +	pci_unlock_rescan_remove();
> > +
> > +out:
> > +	kfree(mns_wk);
> 
> Shouldn't gc->in_service be set to false again?

ah, nevermind. That won't be needed. Thanks
> 
> > +}
> > +
> >  static void mana_gd_process_eqe(struct gdma_queue *eq)
> >  {
> >  	u32 head = eq->head % (eq->queue_size / GDMA_EQE_SIZE);
> >  	struct gdma_context *gc = eq->gdma_dev->gdma_context;
> >  	struct gdma_eqe *eq_eqe_ptr = eq->queue_mem_ptr;
> > +	struct mana_serv_work *mns_wk;
> >  	union gdma_eqe_info eqe_info;
> >  	enum gdma_eqe_type type;
> >  	struct gdma_event event;
> > @@ -400,6 +441,26 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
> >  		eq->eq.callback(eq->eq.context, eq, &event);
> >  		break;
> >  
> > +	case GDMA_EQE_HWC_FPGA_RECONFIG:
> > +	case GDMA_EQE_HWC_SOCMANA_CRASH:
> 
> may be we also add a log(dev_dbg) to indicate if the servicing is for
> FPGA reconfig or socmana crash.
> 
> > +		if (gc->in_service) {
> > +			dev_info(gc->dev, "Already in service\n");
> > +			break;
> > +		}
> > +
> > +		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> > +		if (!mns_wk) {
> > +			dev_err(gc->dev, "Fail to alloc mana_serv_work\n");
> > +			break;
> > +		}
> > +
> > +		dev_info(gc->dev, "Start MANA service\n");
> > +		gc->in_service = true;
> > +		mns_wk->pdev = to_pci_dev(gc->dev);
> > +		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> > +		schedule_work(&mns_wk->serv_work);
> > +		break;
> > +
> >  	default:
> >  		break;
> >  	}
> > diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> > index 228603bf03f2..13cfbcf67815 100644
> > --- a/include/net/mana/gdma.h
> > +++ b/include/net/mana/gdma.h
> > @@ -58,8 +58,9 @@ enum gdma_eqe_type {
> >  	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
> >  	GDMA_EQE_HWC_INIT_DATA		= 130,
> >  	GDMA_EQE_HWC_INIT_DONE		= 131,
> > -	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
> > +	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
> >  	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
> > +	GDMA_EQE_HWC_SOCMANA_CRASH	= 135,
> >  	GDMA_EQE_RNIC_QP_FATAL		= 176,
> >  };
> >  
> > @@ -388,6 +389,8 @@ struct gdma_context {
> >  	u32			test_event_eq_id;
> >  
> >  	bool			is_pf;
> > +	bool			in_service;
> > +
> >  	phys_addr_t		bar0_pa;
> >  	void __iomem		*bar0_va;
> >  	void __iomem		*shm_base;
> > -- 
> > 2.34.1

