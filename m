Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28610218FA3
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 20:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGHSXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 14:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgGHSXI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 14:23:08 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE05206F6;
        Wed,  8 Jul 2020 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594232587;
        bh=C3Gg8Xh5/GKU63Aih3Db7PKPQN75HGOuicquAhDPVeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBsIOnjOUMAOWgWN76b+ljOM9BEq/FtEMKiFm7PszidjdT1wQ3x2iwa5Wf0lEZmlo
         tXwujwYcR79rC3z19OcWo7gIivfenvNe0MyAeo2QbtxMU1tvnC4JztD/Ka3jnTKNmJ
         PDC3yeotegDsXp5gv2eHqJn8kayzoZh+zRb4ZtEw=
Date:   Wed, 8 Jul 2020 13:28:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/hfi1: Use fallthrough pseudo-keyword
Message-ID: <20200708182835.GF11533@embeddedor>
References: <20200707173942.GA29814@embeddedor>
 <20200708054703.GR207186@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708054703.GR207186@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

On Wed, Jul 08, 2020 at 08:47:03AM +0300, Leon Romanovsky wrote:
> On Tue, Jul 07, 2020 at 12:39:42PM -0500, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/infiniband/hw/hfi1/chip.c     |    8 ++++----
> >  drivers/infiniband/hw/hfi1/firmware.c |   16 ----------------
> >  drivers/infiniband/hw/hfi1/mad.c      |    9 ++++-----
> >  drivers/infiniband/hw/hfi1/pio.c      |    2 +-
> >  drivers/infiniband/hw/hfi1/pio_copy.c |   12 ++++++------
> >  drivers/infiniband/hw/hfi1/platform.c |   10 +++++-----
> >  drivers/infiniband/hw/hfi1/qp.c       |    2 +-
> >  drivers/infiniband/hw/hfi1/qsfp.c     |    4 ++--
> >  drivers/infiniband/hw/hfi1/rc.c       |   25 ++++++++++++-------------
> >  drivers/infiniband/hw/hfi1/sdma.c     |    9 ++++-----
> >  drivers/infiniband/hw/hfi1/tid_rdma.c |    4 ++--
> >  drivers/infiniband/hw/hfi1/uc.c       |    8 ++++----
> >  12 files changed, 45 insertions(+), 64 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
> > index 15f9c635f292..132f1df6f23b 100644
> > --- a/drivers/infiniband/hw/hfi1/chip.c
> > +++ b/drivers/infiniband/hw/hfi1/chip.c
> > @@ -7320,7 +7320,7 @@ static u16 link_width_to_bits(struct hfi1_devdata *dd, u16 width)
> >  	default:
> >  		dd_dev_info(dd, "%s: invalid width %d, using 4\n",
> >  			    __func__, width);
> > -		/* fall through */
> > +		fallthrough;
> >  	case 4: return OPA_LINK_WIDTH_4X;
> 
> "case ..:" after "default:" ???
> IMHO, it should be written in more standard way.
> 

I agree. However, that piece of code, and the other below, does not
concern to this patch.

I will address the rest of the comments and send v2.

Thanks!
--
Gustavo

> >  	}
> >  }
> > @@ -7380,7 +7380,7 @@ static void get_link_widths(struct hfi1_devdata *dd, u16 *tx_width,
> >  			dd_dev_err(dd,
> >  				   "%s: unexpected max rate %d, using 25Gb\n",
> >  				   __func__, (int)max_rate);
> > -			/* fall through */
> > +			fallthrough;
> >  		case 1:
> >  			dd->pport[0].link_speed_active = OPA_LINK_SPEED_25G;
> >  			break;
> > @@ -12882,7 +12882,7 @@ static u32 chip_to_opa_lstate(struct hfi1_devdata *dd, u32 chip_lstate)
> >  		dd_dev_err(dd,
> >  			   "Unknown logical state 0x%x, reporting IB_PORT_DOWN\n",
> >  			   chip_lstate);
> > -		/* fall through */
> > +		fallthrough;
> >  	case LSTATE_DOWN:
> >  		return IB_PORT_DOWN;
> >  	case LSTATE_INIT:
> > @@ -12901,7 +12901,7 @@ u32 chip_to_opa_pstate(struct hfi1_devdata *dd, u32 chip_pstate)
> >  	default:
> >  		dd_dev_err(dd, "Unexpected chip physical state of 0x%x\n",
> >  			   chip_pstate);
> > -		/* fall through */
> > +		fallthrough;
> >  	case PLS_DISABLED:
> >  		return IB_PORTPHYSSTATE_DISABLED;
> >  	case PLS_OFFLINE:
> 
> same comment.
> 
> 
> > diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
> > index 2b57ba70ddd6..0e83d4b61e46 100644
> > --- a/drivers/infiniband/hw/hfi1/firmware.c
> > +++ b/drivers/infiniband/hw/hfi1/firmware.c
> > @@ -1868,11 +1868,8 @@ int parse_platform_config(struct hfi1_devdata *dd)
> >  									2;
> >  				break;
> >  			case PLATFORM_CONFIG_RX_PRESET_TABLE:
> > -				/* fall through */
> >  			case PLATFORM_CONFIG_TX_PRESET_TABLE:
> > -				/* fall through */
> >  			case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
> > -				/* fall through */
> >  			case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
> >  				pcfgcache->config_tables[table_type].num_table =
> >  							table_length_dwords;
> > @@ -1890,15 +1887,10 @@ int parse_platform_config(struct hfi1_devdata *dd)
> >  			/* metadata table */
> >  			switch (table_type) {
> >  			case PLATFORM_CONFIG_SYSTEM_TABLE:
> > -				/* fall through */
> >  			case PLATFORM_CONFIG_PORT_TABLE:
> > -				/* fall through */
> >  			case PLATFORM_CONFIG_RX_PRESET_TABLE:
> > -				/* fall through */
> >  			case PLATFORM_CONFIG_TX_PRESET_TABLE:
> > -				/* fall through */
> >  			case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
> > -				/* fall through */
> >  			case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
> >  				break;
> >  			default:
> > @@ -2027,15 +2019,10 @@ static int get_platform_fw_field_metadata(struct hfi1_devdata *dd, int table,
> >
> >  	switch (table) {
> >  	case PLATFORM_CONFIG_SYSTEM_TABLE:
> > -		/* fall through */
> >  	case PLATFORM_CONFIG_PORT_TABLE:
> > -		/* fall through */
> >  	case PLATFORM_CONFIG_RX_PRESET_TABLE:
> > -		/* fall through */
> >  	case PLATFORM_CONFIG_TX_PRESET_TABLE:
> > -		/* fall through */
> >  	case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
> > -		/* fall through */
> >  	case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
> >  		if (field && field < platform_config_table_limits[table])
> >  			src_ptr =
> > @@ -2138,11 +2125,8 @@ int get_platform_config_field(struct hfi1_devdata *dd,
> >  			pcfgcache->config_tables[table_type].table;
> >  		break;
> >  	case PLATFORM_CONFIG_RX_PRESET_TABLE:
> > -		/* fall through */
> >  	case PLATFORM_CONFIG_TX_PRESET_TABLE:
> > -		/* fall through */
> >  	case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
> > -		/* fall through */
> >  	case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
> >  		src_ptr = pcfgcache->config_tables[table_type].table;
> >
> > diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
> > index 7073f237a949..3222e3acb79c 100644
> > --- a/drivers/infiniband/hw/hfi1/mad.c
> > +++ b/drivers/infiniband/hw/hfi1/mad.c
> > @@ -721,7 +721,7 @@ static int check_mkey(struct hfi1_ibport *ibp, struct ib_mad_hdr *mad,
> >  			/* Bad mkey not a violation below level 2 */
> >  			if (ibp->rvp.mkeyprot < 2)
> >  				break;
> > -			/* fall through */
> > +			fallthrough;
> >  		case IB_MGMT_METHOD_SET:
> >  		case IB_MGMT_METHOD_TRAP_REPRESS:
> >  			if (ibp->rvp.mkey_violations != 0xFFFF)
> > @@ -1272,7 +1272,7 @@ static int set_port_states(struct hfi1_pportdata *ppd, struct opa_smp *smp,
> >  	case IB_PORT_NOP:
> >  		if (phys_state == IB_PORTPHYSSTATE_NOP)
> >  			break;
> > -		/* FALLTHROUGH */
> > +		fallthrough;
> >  	case IB_PORT_DOWN:
> >  		if (phys_state == IB_PORTPHYSSTATE_NOP) {
> >  			link_state = HLS_DN_DOWNDEF;
> > @@ -2300,7 +2300,6 @@ static int __subn_set_opa_vl_arb(struct opa_smp *smp, u32 am, u8 *data,
> >  	 * can be changed from the default values
> >  	 */
> >  	case OPA_VLARB_PREEMPT_ELEMENTS:
> > -		/* FALLTHROUGH */
> >  	case OPA_VLARB_PREEMPT_MATRIX:
> >  		smp->status |= IB_SMP_UNSUP_METH_ATTR;
> >  		break;
> > @@ -4170,7 +4169,7 @@ static int subn_get_opa_sma(__be16 attr_id, struct opa_smp *smp, u32 am,
> >  			return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
> >  		if (ibp->rvp.port_cap_flags & IB_PORT_SM)
> >  			return IB_MAD_RESULT_SUCCESS;
> > -		/* FALLTHROUGH */
> > +		fallthrough;
> >  	default:
> >  		smp->status |= IB_SMP_UNSUP_METH_ATTR;
> >  		ret = reply((struct ib_mad_hdr *)smp);
> > @@ -4240,7 +4239,7 @@ static int subn_set_opa_sma(__be16 attr_id, struct opa_smp *smp, u32 am,
> >  			return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
> >  		if (ibp->rvp.port_cap_flags & IB_PORT_SM)
> >  			return IB_MAD_RESULT_SUCCESS;
> > -		/* FALLTHROUGH */
> > +		fallthrough;
> >  	default:
> >  		smp->status |= IB_SMP_UNSUP_METH_ATTR;
> >  		ret = reply((struct ib_mad_hdr *)smp);
> > diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
> > index 79126b2b14ab..ff864f6f0266 100644
> > --- a/drivers/infiniband/hw/hfi1/pio.c
> > +++ b/drivers/infiniband/hw/hfi1/pio.c
> > @@ -86,7 +86,7 @@ void pio_send_control(struct hfi1_devdata *dd, int op)
> >  	switch (op) {
> >  	case PSC_GLOBAL_ENABLE:
> >  		reg |= SEND_CTRL_SEND_ENABLE_SMASK;
> > -	/* Fall through */
> > +		fallthrough;
> >  	case PSC_DATA_VL_ENABLE:
> >  		mask = 0;
> >  		for (i = 0; i < ARRAY_SIZE(dd->vld); i++)
> > diff --git a/drivers/infiniband/hw/hfi1/pio_copy.c b/drivers/infiniband/hw/hfi1/pio_copy.c
> > index 03024cec78dd..b12e4665c9ab 100644
> > --- a/drivers/infiniband/hw/hfi1/pio_copy.c
> > +++ b/drivers/infiniband/hw/hfi1/pio_copy.c
> > @@ -191,22 +191,22 @@ static inline void jcopy(u8 *dest, const u8 *src, u32 n)
> >  	switch (n) {
> >  	case 7:
> >  		*dest++ = *src++;
> > -		/* fall through */
> > +		fallthrough;
> >  	case 6:
> >  		*dest++ = *src++;
> > -		/* fall through */
> > +		fallthrough;
> >  	case 5:
> >  		*dest++ = *src++;
> > -		/* fall through */
> > +		fallthrough;
> >  	case 4:
> >  		*dest++ = *src++;
> > -		/* fall through */
> > +		fallthrough;
> >  	case 3:
> >  		*dest++ = *src++;
> > -		/* fall through */
> > +		fallthrough;
> >  	case 2:
> >  		*dest++ = *src++;
> > -		/* fall through */
> > +		fallthrough;
> >  	case 1:
> >  		*dest++ = *src++;
> >  		/* fall through */
> 
> This is missed and it seems that one memcpy will do the same.
> 
> > diff --git a/drivers/infiniband/hw/hfi1/platform.c b/drivers/infiniband/hw/hfi1/platform.c
> > index 36593f2efe26..4642d6ceb890 100644
> > --- a/drivers/infiniband/hw/hfi1/platform.c
> > +++ b/drivers/infiniband/hw/hfi1/platform.c
> > @@ -668,8 +668,8 @@ static u8 aoc_low_power_setting(struct hfi1_pportdata *ppd)
> >
> >  	/* active optical cables only */
> >  	switch ((cache[QSFP_MOD_TECH_OFFS] & 0xF0) >> 4) {
> > -	case 0x0 ... 0x9: /* fallthrough */
> > -	case 0xC: /* fallthrough */
> > +	case 0x0 ... 0x9: fallthrough;
> > +	case 0xC: fallthrough;
> 
> fallthrough is not needed.
> 
> >  	case 0xE:
> >  		/* active AOC */
> >  		power_class = get_qsfp_power_class(cache[QSFP_MOD_PWR_OFFS]);
> > @@ -899,8 +899,8 @@ static int tune_qsfp(struct hfi1_pportdata *ppd,
> >
> >  		*ptr_tuning_method = OPA_PASSIVE_TUNING;
> >  		break;
> > -	case 0x0 ... 0x9: /* fallthrough */
> > -	case 0xC: /* fallthrough */
> > +	case 0x0 ... 0x9: fallthrough;
> > +	case 0xC: fallthrough;
> 
> same
> 
> Thanks
