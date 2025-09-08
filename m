Return-Path: <linux-rdma+bounces-13148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA29B484D1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B907177F9D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 07:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40C2E370E;
	Mon,  8 Sep 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIW0bKVb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E38747F
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315460; cv=none; b=oSyp54ko25WjkcXFMD3KPtgntYEZ4S5u2u3u4EaXZtTsryI2eBzediOBwpb1NaaFUhb58dN7nhCBEHPudcHcn5NvtLqKIMyGbPtwAZB4zNmVhDP3t+ZTkdyz+xQdUHRC46YY8NlyE6sJppg42u2c1N2HcWPizXnOUtG2MoATCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315460; c=relaxed/simple;
	bh=Kd8qDpsfRSxGlE7HcIWkJnUMUiEMO/LghzBCtC9PKlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFJZhMLN9HhaU0RowXgSbVtSW4UnnT8DrjMILv+sYSNF4BJBckQ/T4kMZOYgqrjQab2tUcVU8dHwmo6f6ThMmUXtJJlqFGW8j3ayIhrrPtUNZgoFjKwMbu30we8wYaARuHIyYFi/569UeJ03meovSBKw5rRe6b+FDEHFIINOV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIW0bKVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1678C4CEF5;
	Mon,  8 Sep 2025 07:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757315459;
	bh=Kd8qDpsfRSxGlE7HcIWkJnUMUiEMO/LghzBCtC9PKlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIW0bKVbPe/I/8DNa2cvbNckX40OKNVUTGNGTfLq6YLItM2jACDsxaj4+yEdkqqEH
	 41ePadCxG5aubZTEZWBPDzMiRTruUtwElFmOrse3e/SdMUo0D+niuNydmBtKhKaHOx
	 6IRGq7MmcXL8edp2ZTDlU2wXQO9k/+bbf8gNxJq+UOKxr9pho/HBKfOWWOHuNwNhnD
	 a/gPkHP+2eNzpFZdCI72DlYuDAmlHXEwEGtH5EnBrIOltOQKec3O1ZfGAjeTA4R1rn
	 RGVBwDfroHHfxtYWyYdAeMVLGoup27Ec/Pv+7Evr9rsVXZwbDt1kuqgXSNfKccu0qV
	 wM8Ee52lRmRfw==
Date: Mon, 8 Sep 2025 10:10:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 0/9] bnxt_re enhancements
Message-ID: <20250908071055.GE25881@unreal>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>

On Thu, Aug 14, 2025 at 04:55:46PM +0530, Kalesh AP wrote:
> Hi,
> 
> This patchset contains few enhancements in the bnxt_re driver.
> 
> Please review.
> 
> Abhishek Mohapatra (1):
>   RDMA/bnxt_re: Report udp source port for flow_label in
>     bnxt_re_query_qp
> 
> Chenna Arnoori (1):
>   RDMA/bnxt_re: RoCE Driver Dynamic Debug for HWRM's
> 
> Damodharam Ammepalli (1):
>   RDMA/bnxt_re: Optimize bnxt_qplib_get_dev_attr function
> 
> Kalesh AP (2):
>   RDMA/bnxt_re: Delete always true SGID table check
>   RDMA/bnxt_re: Enhance a log message when bnxt_re_register_netdev fails
> 
> Kashyap Desai (1):
>   RDMA/bnxt_re: show srq_limit in fill_res_srq_entry hook
>
> Vasuthevan Maheswaran (1):
>   RDMA/bnxt_re: RoCE related hardware counters update
>

Applied to wip/leon-for-next

> Anantha Prabhu (1):
>   RDMA/bnxt_re: Update sysfs entries with appropriate data
> 
> Shravya KN (1):
>   RDMA/bnxt_re: Avoid GID level QoS update from the driver
> 

These need to be resent.

Thanks

