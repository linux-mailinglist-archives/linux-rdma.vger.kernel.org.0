Return-Path: <linux-rdma+bounces-3938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20D939FA2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2024 13:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F4F1C21E77
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA614F9E0;
	Tue, 23 Jul 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6cqaJZM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034A14A4DA;
	Tue, 23 Jul 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733629; cv=none; b=k7PNs89oONw/uJQ22tQdNDID3DbpBb0GJPFuME8mRjN5G1XQJHFTbvNk5eF++sKzXuXeK2ptVgGBHG2yrzk5f9KZiHxkOXfORMmU/qlZd6yqcJBshf/5HynQQdPIHzJX+4Bg7L/PL7CemEC9mgYFfxifv6cWpdEYjUCxQ5lv34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733629; c=relaxed/simple;
	bh=jgZdHuVEZGuA7kFRLF7nUJzUNqamLDIW5jmqbi/tYag=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GIAbgrMbYry9cioNrrfleJL1w8heUJblgGTuxZjKcHMpry9ea2RWSjL78fixrGhKqzeXrLrjsJJrFRr6tqBu8ZLXzA7XDs8gWMcZhC/NFDkY+czWgRS4wTJW7Q8gpoVGdhr1MwpUMoW4wpyNZpJ0R9A+Uja5gPSJyO6Z05VWj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6cqaJZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401AAC4AF09;
	Tue, 23 Jul 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721733628;
	bh=jgZdHuVEZGuA7kFRLF7nUJzUNqamLDIW5jmqbi/tYag=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=o6cqaJZMhb4/vMNNoXzkbLhEonha54RaAaU7Ns9Thes29uQHSe6i2U1jPynbkD1uX
	 wFqF2kL9C4oUN2Ant4wKZrAJ+rwq82NnH67C78jfrcVMS+IE9lkg0nBJkaa59qlZwX
	 2LnTh4aj19Z12k9pQ9CZE3BDR3f9zqB0comDXVUt+dLaT8eDNcJJwEn7ZSfeOZzJ0q
	 nw/kNbeD8SAJP9W0YY89l5DeY8SwJI9YP+/s8xCKaODqcG/8TQO02xjIt/Pfm9T4qc
	 jGtdZmYCCRi2P+6RO8J/u0mqZbguOBGlAWp2OTSKfDacUOC+t+jQVNrTplSrPzrfRx
	 4xKxOAXCsCe2g==
Date: Tue, 23 Jul 2024 13:20:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
cc: ksummit@lists.linux.dev, linux-cxl@vger.kernel.org, 
    linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
In-Reply-To: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Jul 2024, Dan Williams wrote:

> 2/ Device passthrough, kernel passing opaque payloads, is already taken
>    for granted in many subsystems. USB and HID have "raw" interfaces

Just as a completely random datapoint here: after I implemented hidraw 
inteface long time ago, I was a little bit hesitant about really merging 
it, because there was a general fear that this would shatter the HID 
driver ecosystem, making it difficult for people to find proper drivers 
for their devices, etc.

Turns out that that didn't happen. Drivers for generic devices are still 
implemented properly in the kernel, and hidraw is mostly used for rather 
specific, one-off solutions, where the vendor's business plan is "ship 
this one appliance and forget forever", which doesn't really cause any 
harm to the whole ecosystem.

-- 
Jiri Kosina
SUSE Labs


