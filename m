Return-Path: <linux-rdma+bounces-3163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5B909AE3
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 03:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D400282C72
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 01:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0064C83;
	Sun, 16 Jun 2024 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YBijmTXK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208688F6E;
	Sun, 16 Jun 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718499882; cv=none; b=Yf4MWTEYWDf7Mp5KV70vEwWFdKZ2EkmIdzOqpJVJSi/Ka6ClQXxooB7QBt193y39X+k0fJEz5glicT0LB8ftJRx8poLO6jNkoKrSqWnpc9C/3iHlpXQmIGCIxNBvPKzeJOwzEe8KjagQg79FxLnA+SWQHXSV+Fgf00lR2jNH9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718499882; c=relaxed/simple;
	bh=WooHkqJHffhYJxXZwkctparIfpgUJvEQ9yd2rn7ck1M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKsVhcnf6LMoDERS7I4hvJnkpDIrxRe8OqnEfti2ZQd9N/F76sISSsEeScrt12NlTyXOKWWKdj/f6MMYwRERiDVZPz+42yQA1kAloa9jZ7uY6+AX+MrT6UDiMZpCqwQdYcmSFSHskO7keH+oQRbm7oW+h+lH/iqNb2QAxf0ambk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YBijmTXK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UgZuhckA4p+XwquMniU0ZCZJXZSNdwe4LEu1KmZDzzs=; b=YBijmTXKln3H3WysHSl6eFQTvD
	7NaOk9ZOZy5kH+fiH+AMkgIz6sNg3F33/VkFmT+mWseBh7K9zbJlOrTEKaQJ9iJSZ3M1SYF8lo87l
	Eh63XcYpyTDKl2704V+B8ZYDurmvMSwsSMSTXvFONCG64FRhoc34ENeld5usSdE5fnQ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIeJw-0009pt-MD; Sun, 16 Jun 2024 03:04:36 +0200
Date: Sun, 16 Jun 2024 03:04:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joe Damato <jdamato@fastly.com>,
	Omer Shpigelman <oshpigelman@habana.ai>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	ogabbay@kernel.org, zyehudai@habana.ai
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <990a55b5-4a98-47bb-bea6-9b85f061a788@lunn.ch>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-10-oshpigelman@habana.ai>
 <ZmzIy3c0j8ubspIM@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmzIy3c0j8ubspIM@LQ3V64L9R2>

On Fri, Jun 14, 2024 at 03:48:43PM -0700, Joe Damato wrote:
> On Thu, Jun 13, 2024 at 11:22:02AM +0300, Omer Shpigelman wrote:
> > This ethernet driver is initialized via auxiliary bus by the hbl_cn
> > driver.
> > It serves mainly for control operations that are needed for AI scaling.
> > 
> > Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> > Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> > Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> > Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> > Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> > Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> > Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> > Co-developed-by: David Meriin <dmeriin@habana.ai>
> > Signed-off-by: David Meriin <dmeriin@habana.ai>
> > Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> > Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> > Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>

Hi Joe

Please trim emails to include just the relevant context when
replying. It is hard to see your comments, and so it is likely some
will be missed, and you will need to make the same comment on v2.

     Andrew

