Return-Path: <linux-rdma+bounces-8691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09351A60854
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 06:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B3F19C1F9D
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24513D53B;
	Fri, 14 Mar 2025 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YKW52vZK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBE22339;
	Fri, 14 Mar 2025 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741930636; cv=none; b=EyUY3fDnfgvF6dLJ9dA4a0m/iJu+CGSLVB4yYkgvcUtObYl+fGnDxh7XZwuIIS+Om/cH8KAFoOA3Fj0svKDWVjyeIGsVaDxn7DXb5Hde14g9cZ8E2IL4sDITdYWcDm+lTzgG6ZChMZlRxiXuclak5uFaTr6wadse0pKf/MQGoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741930636; c=relaxed/simple;
	bh=joNCjCEtVPa/tnAVU/qPppuc1NRidagR8E9SICraH2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2SX/DYeAXcqY6WwrMTexTDJjp0L2ME53iBmRNUBwbo54u8XEGnEo2oj6id7PMz7mEHxtfO8VZuClLwWMV5U+XsvFYJd5/uLZAQ3wlydf9s77FeIVEPCxdEK8uC3tV5K/r1co1bdOj82qgv6QL8budcWI60B+nWlyHlXkjGwzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YKW52vZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F29CC4CEEB;
	Fri, 14 Mar 2025 05:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741930634;
	bh=joNCjCEtVPa/tnAVU/qPppuc1NRidagR8E9SICraH2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKW52vZKcNWqPMg2G0+uLZQwGe7GRFSvyrd+UwdWUXDrcauqfww++wdd5K29MYqf0
	 BBeXfkYwpjD6LBF4zpoK0scWDh/9Ay7RpZH7ZxARod3xV2QjBlMnV7rY7NcvMF46gT
	 CMBwVdkRdEtjFGrhRDmH55aiE77/3QfGOBN6ikeM=
Date: Fri, 14 Mar 2025 06:37:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <2025031408-frequency-oxidant-287f@gregkh>
References: <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>

On Thu, Mar 13, 2025 at 12:59:16PM -0700, Nelson, Shannon wrote:
> On 3/13/2025 5:48 AM, Leon Romanovsky wrote:
> > On Thu, Mar 13, 2025 at 01:30:52PM +0100, David Ahern wrote:
> 
> 
> > > So that means 3 different vendors and 3 different devices looking for a
> > > similar auxbus based hierarchy with a core driver not buried within one
> > > of the subsystems.
> > > 
> > > I guess at this point we just need to move forward with the proposal and
> > > start sending patches.
> > > 
> > > Seems like drivers/core is the consensus for the core driver?
> > 
> > Yes, anything that is not aux_core is fine by me.
> > 
> > drivers/core or drivers/aux.
> 
> Between the two of these I prefer drivers/core - I don't want to see this
> tied to aux for the same reasons we don't want it tied to pci or net.

Decades ago we tried to add drivers/core/ but I think tools really
didn't like to see "core" as a directory name.  Hopefully you all don't
run into that issue here as well :)

Anyway, if you all want me to run that tree as a "neutral" third-party,
I'll be glad to do so.

thanks,

greg k-h

