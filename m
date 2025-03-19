Return-Path: <linux-rdma+bounces-8807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A59A68661
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2931B880E8E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF423251788;
	Wed, 19 Mar 2025 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9bN8+Po"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0582512FD;
	Wed, 19 Mar 2025 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371498; cv=none; b=VzAn8r+tZz6cFGn6fhrBYXBEaZ5fs9ixF1zCXHuU+e64iZcniO6FM0MHLmi9X4UziV+YwPlN+FK8aM0U0DXaCHn+hllTdZFaPD5mDl36VImKjl3D3NYipqxliVKE30posrcm7Yytj+EqAZtTkcB/MB9B83J4ZTpUT7u2VJzDSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371498; c=relaxed/simple;
	bh=5c9Wsoq1MqSD3TR0ypeiF676vfndF7v+iU5L7FrV9Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxQAMfuOnjHYUGGb78fZ/qPixOGTTIl/sNGzOXFAZQse+Ubo//A70ClQ42xAaR3INsgriFjmAjJsYiT3drMmmHVJqbYkDij925maWDlKBQQzkGHaJWjrK6kdWQHbozuD+2jMUpDFEFM2ynTZdZLPk46YfaN3hgVWrnX7E7CHMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9bN8+Po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75431C4CEEA;
	Wed, 19 Mar 2025 08:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742371498;
	bh=5c9Wsoq1MqSD3TR0ypeiF676vfndF7v+iU5L7FrV9Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9bN8+Po8pf/YBZL3DmN75kiDB/zybI3lKt4MKgau/Jaw95AJ0MC0ZyPns5+jy04i
	 3xVLjpQrS4QHwzTdeTF7nrRX+O5/yU6dT+OrXk6jHf6U5QzjJi6C8DcjqjelKROV06
	 VnzJfdNEKfvAqYjpKKnj0LtYxIkg6iv41m/Gj+GownLOdoO3QCkG8qPMwUYVzyNRn7
	 6eTrpLkAYq9D0FJI15Lj9g2K9Gx7SlYcB8zj0lQSyxjxKx7xjR8CLPOUo32FbGDrrr
	 sDdiN7YFLrpYigm/nGvynKUDU82fNJf0JMv7167anBCguZx90ND2PniDOJ9/ExmjaM
	 SGRqDtK4fNrpg==
Date: Wed, 19 Mar 2025 10:04:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: "Ertman, David M" <david.m.ertman@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [iwl-next v4 1/1] iidc/ice/irdma: Update IDC
 to support multiple consumers
Message-ID: <20250319080453.GD1322339@unreal>
References: <20250226185022.GM53094@unreal>
 <IA1PR11MB6194C8F265D13FE65EA006C2DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250302082623.GN53094@unreal>
 <07e75573-9fd0-4de1-ac44-1f6a5461a6b8@intel.com>
 <20250314181230.GP1322339@unreal>
 <8b4868dd-f615-4049-a885-f2f95a3e7a54@intel.com>
 <20250317115728.GT1322339@unreal>
 <dc96e73c-391a-4d54-84db-ece96939d45d@intel.com>
 <20250318172026.GA9311@nvidia.com>
 <2e29a3f3-1c74-461a-a7ae-efe6c429fa1f@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e29a3f3-1c74-461a-a7ae-efe6c429fa1f@intel.com>

On Tue, Mar 18, 2025 at 12:45:48PM -0700, Samudrala, Sridhar wrote:
> 
> 
> On 3/18/2025 10:20 AM, Jason Gunthorpe wrote:
> > On Tue, Mar 18, 2025 at 10:01:36AM -0700, Samudrala, Sridhar wrote:
> > 
> > > Yes. Today irdma uses exported symbols from i40e and ice and loading irdma
> > > results in both modules to be loaded even when only type of NIC is present
> > > on a system. This series is trying to remove that dependency by using
> > > callbacks.
> > 
> > If you really have two different core drivers that can provide the
> > same API then I think you are stuck with function pointers :\
> > 
> > It is really weird though, why are their two core drivers that can
> > provide the same API? Is this because intel keeps rewriting their
> > driver stack every few years?
> 
> This is a known issue due to HW/FW interface changes across multiple
> generations of the NICs forcing us to go with separate core drivers.
> 
> We are working with HW/FW teams to avoid this in future and going forward we
> expect to have idpf/ixd as the 2 drivers (idpf providing the data path
> functionality and ixd as the control/data/switchdev port-rep driver) for all
> our future FNICs/IPUs.
> 
> Leon, Could you approve the callbacks approach considering that irdma needs
> to support multiple intel nic core drivers. We would really appreciate it.

I'm not approving or denying anything. I just expressed my view on the
idea to reinvent wheel. It is not HW bug which prevents from you to use
Intel HW, but some bad architecture decision. This decision leads to
extra memory waste and nothing more.

If I remember correctly, the use of "i40e and ice" at the same time is an outcome
of Intel's decision to keep (and rename) old driver which supported iWARP only
to support both iWARP and RoCE.

Even then, that architecture decision wasn't well received.

RDMA subsystem has another maintainer, who can and should have different
opinions from me, you can try to convince him that function pointers is
the right approach here. I think that it is not, extra waste of memory
is a small price to pay for such architecture decision.

Thanks

> 
> -SridharW
> 

