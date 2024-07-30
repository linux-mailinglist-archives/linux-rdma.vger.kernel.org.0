Return-Path: <linux-rdma+bounces-4124-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A89422BA
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890821C216C6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA391190473;
	Tue, 30 Jul 2024 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LJ0i3kBM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B32157466;
	Tue, 30 Jul 2024 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378234; cv=none; b=dpf0XdFm2q25Ob3i9NuaQPGNSoI8wWtNYq/wxtmIRX8NUX70L1cUWYdPj+w8ZyhGkAM0OBXBcEwci0NlMIGJPOTONDKW4kyULi6B8L6qW/07O6RsJjoRXJuHmRefoqjmomnuaRR9okEBKosWvf//JlubKhk6Ih5NGf/QIr3MaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378234; c=relaxed/simple;
	bh=fxqK6isVZYwjWROTSakPQHD1uYqeONWbVadqH001MSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcuNn1zoFjH4UKJTPjyu/KRpZetlHFHpUFzstfU9ZCD+AM0FjL6/7cdCyS2RveXtxwg0ayiN6n6ls7sO3ktsp8ZTYdMfFFAmZumMmfEChnJr4YVNkFkTXP/Df70DNZNGYb4vbklPdz7CW1ZoaajCxLlMN1kJl/cd9jfpBCxzA5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LJ0i3kBM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P+25ADvoROh3ffi6FNyXx7pUdybk/3nfa31XZxVnXGU=; b=LJ0i3kBMZtOgfYX0X+jr54WU8/
	W9xQIb84pCCea3gJlCjH4CUOTRsN58XNQQkw1cWWUVUVVmgRXXNlEIHeyL/z9d3Rdjsu/ftFIK2A+
	3kUnKkYLcHRCPVzJwl8Di/BMkS4Z2Xwl/4uOGous4gtTb2lM78upQP3gmpQsfxhLuKMF5IhsviSjB
	EPWVtOn4FotVQNh+VkMMMt34vncPV1seypghmuIvDESSHvGij99auSvphf97GDCbf4tTNSJx82Dum
	Rqw56fcYvcgp6asoejhVC/CkEJ6Hmd/113iofRhS3veG4ojBhx2bLd4MwbWB+JP1Fn/D5F9oFrCCX
	zcpAN3mw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36616)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYvFI-0007jE-17;
	Tue, 30 Jul 2024 23:23:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYvFB-0005am-Gh; Tue, 30 Jul 2024 23:22:57 +0100
Date: Tue, 30 Jul 2024 23:22:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Allen Pais <allen.lkml@gmail.com>, kuba@kernel.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	jes@trained-monkey.org, kda@linux-powerpc.org,
	cai.huoqing@linux.dev, dougmill@linux.ibm.com, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com, cooldavid@cooldavid.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	louis.peens@corigine.com, richardcochran@gmail.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acenic@sunsite.dk, linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Subject: Re: [net-next v3 14/15] net: marvell: Convert tasklet API to new
 bottom half workqueue mechanism
Message-ID: <ZqlnwSDCvhrRe32K@shell.armlinux.org.uk>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
 <20240730183403.4176544-15-allen.lkml@gmail.com>
 <fbb19744-cc77-4541-90b5-0760e0eeae22@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb19744-cc77-4541-90b5-0760e0eeae22@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 30, 2024 at 10:39:51PM +0200, Andrew Lunn wrote:
> > - * Called only from mvpp2_txq_done(), called from mvpp2_tx()
> > - * (migration disabled) and from the TX completion tasklet (migration
> > - * disabled) so using smp_processor_id() is OK.
> > + * Called only from mvpp2_txq_done().
> > + *
> > + * Historically, this function was invoked directly from mvpp2_tx()
> > + * (with migration disabled) and from the bottom half workqueue.
> > + * Verify that the use of smp_processor_id() is still appropriate
> > + * considering the current bottom half workqueue implementation.
> 
> What does this mean? You want somebody else to verify this? You are
> potentially breaking this driver?

I don't see how, the only thing that's changing in mvpp2 seems to be
an outdated comment that happens to mention a tasklet, but the
driver doesn't use tasklets.

Let's look at the original comment which claims what the call sites
are:

static void mvpp2_txq_done(struct mvpp2_port *port, struct mvpp2_tx_queue *txq,
                           struct mvpp2_txq_pcpu *txq_pcpu)
{
...
        tx_done = mvpp2_txq_sent_desc_proc(port, txq);

and that is it. _This_ function is called from several places:

mvpp2_tx_done()
mvpp2_xdp_finish_tx()
mvpp2_tx()

So I suppose that the original comment was referring to the
mvpp2_tx() -> mvpp2_txq_done() -> mvpp2_txq_sent_desc_proc() call path,
and the others were added over time.

mvpp2_tx_done() is called from mvpp2_hr_timer_cb(), and yes, back in
the distant history there was a tasklet here - see:

ecb9f80db23a net/mvpp2: Replace tasklet with softirq hrtimer

So, the comment referring to a tasklet was left over from that commit
and never fixed up.

Given this, I don't think the new paragraph starting "Historically"
is correct (or even relevant) as I think it misinterprets the original
comment - and "this function" is ambiguous in it, but either way its
still wrong.

If we assume that "this function" refers to the one below the comment,
then this has never been called directly from mvpp2_tx() nor the
tasklet, and talking about a bottom half workqueue makes no sense
because "historically" it's never been called from a bottom half
workqueue.

If we assume that "this function" refers to mvpp2_txq_done(), then
it's not historical that this was called from mvpp2_tx(), because it
still is today. And the bit about being called from a bottom half
workqueue is still false.

Given that bottom half workqueues have absolutely nothing to do with
this code path, the sentence beginning with "Verify" seems totally
irrelevant (at least to me.)

So, I think I've comprehensively ripped the new comment to shreds.
It would be far better to leave the driver alone and not change the
comment despite it incorrectly referring to a tasklet that has
already been eliminated (and at least was historically correct),
rather than the new comment which just seems wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

