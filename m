Return-Path: <linux-rdma+bounces-19377-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHKlGCHi32kzZwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19377-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 21:08:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C80D40749B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 21:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C0B30151EB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 19:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDA638425D;
	Wed, 15 Apr 2026 19:05:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436F40DFA7;
	Wed, 15 Apr 2026 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279901; cv=none; b=PuWJiUzU2RLbNxPhxMflgZPnngrTiYvC/uYfZhLRdTLZIHN2usCNrKFvbrAUGO+vP61qhkSIuHzfNci1SCkB1CnI8+b+DcFfeTMkv9EWTbLYL27sWwRy8kyzCdeW+yKXgrtaTBGiiC11ujejURwU7wYfFmVjqSkZF6mTeRhefG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279901; c=relaxed/simple;
	bh=gVVPxbvdn0cCwIIKCjiY3NHeFS6oYMS7bCJlpf9Xv8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXdoIV1VUoyT3A5R93CmHO+BzNgNVIuL9v0V7YIWg6fw8EjagTiMT+18hYBdBqjjESLUFRYwHFJxmLQbox0lQzyLF2+TJ/kaF0r1e4gP0vkRlCkED6+B/KR5aRBepIFOUS4L8zCnnHZ6xlg/G2yvM0sweNapponqYIfhaQ5/YH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9FDC19424;
	Wed, 15 Apr 2026 19:04:56 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: jiri@resnulli.us
Cc: andrew+netdev@lunn.ch,
	chuck.lever@oracle.com,
	cjubran@nvidia.com,
	corbet@lwn.net,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	matttbe@kernel.org,
	mbloch@nvidia.com,
	mhiramat@kernel.org,
	mschmidt@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	rostedt@goodmis.org,
	saeedm@nvidia.com,
	skhan@linuxfoundation.org,
	tariqt@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 04/13] devlink: allow to use devlink index as a command handle
Date: Wed, 15 Apr 2026 21:04:54 +0200
Message-ID: <20260415190454.2632348-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312100407.551173-5-jiri@resnulli.us>
References: <20260312100407.551173-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19377-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,nvidia.com,lwn.net,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,efficios.com,redhat.com,intel.com,goodmis.org,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-rdma@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:mid,linux-m68k.org:email,nvidia.com:email]
X-Rspamd-Queue-Id: 0C80D40749B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026, Jiri Pirko wrote:
> Currently devlink instances are addressed bus_name/dev_name tuple.
> Allow the newly introduced DEVLINK_ATTR_INDEX to be used as
> an alternative handle for all devlink commands.
> 
> When DEVLINK_ATTR_INDEX is present in the request, use it for a direct
> xarray lookup instead of iterating over all instances comparing
> bus_name/dev_name strings.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Thanks for your patch, which is now commit d85a8af57da87196 ("devlink:
allow to use devlink index as a command handle").

This has a rather large impact on kernel size.
For e.g. m68k/atari_defconfig, bloat-o-meter reports:

    add/remove: 4/1 grow/shrink: 72/1 up/down: 65804/-76 (65728)
    Function                                     old     new   delta
    devlink_trap_policer_get_dump_nl_policy       24    1480   +1456
    devlink_trap_group_get_dump_nl_policy         24    1480   +1456
    devlink_trap_get_dump_nl_policy               24    1480   +1456
    devlink_selftests_get_nl_policy               24    1480   +1456
    devlink_sb_tc_pool_bind_get_dump_nl_policy      24    1480   +1456
    devlink_sb_port_pool_get_dump_nl_policy       24    1480   +1456
    devlink_sb_pool_get_dump_nl_policy            24    1480   +1456
    devlink_sb_get_dump_nl_policy                 24    1480   +1456
    devlink_resource_dump_nl_policy               24    1480   +1456
    devlink_region_get_dump_nl_policy             24    1480   +1456
    devlink_rate_get_dump_nl_policy               24    1480   +1456
    devlink_port_get_dump_nl_policy               24    1480   +1456
    devlink_param_get_dump_nl_policy              24    1480   +1456
    devlink_linecard_get_dump_nl_policy           24    1480   +1456
    devlink_info_get_nl_policy                    24    1480   +1456
    devlink_get_nl_policy                         24    1480   +1456
    devlink_eswitch_get_nl_policy                 24    1480   +1456
    devlink_dpipe_headers_get_nl_policy           24    1480   +1456
    devlink_port_unsplit_nl_policy                32    1480   +1448
    devlink_port_param_set_nl_policy              32    1480   +1448
    devlink_port_param_get_nl_policy              32    1480   +1448
    devlink_port_get_do_nl_policy                 32    1480   +1448
    devlink_port_del_nl_policy                    32    1480   +1448
    devlink_notify_filter_set_nl_policy           32    1480   +1448
    devlink_health_reporter_get_dump_nl_policy      32    1480   +1448
    devlink_port_split_nl_policy                  80    1480   +1400
    devlink_sb_occ_snapshot_nl_policy             96    1480   +1384
    devlink_sb_occ_max_clear_nl_policy            96    1480   +1384
    devlink_sb_get_do_nl_policy                   96    1480   +1384
    devlink_sb_port_pool_get_do_nl_policy        144    1480   +1336
    devlink_sb_pool_get_do_nl_policy             144    1480   +1336
    devlink_sb_pool_set_nl_policy                168    1480   +1312
    devlink_sb_port_pool_set_nl_policy           176    1480   +1304
    devlink_sb_tc_pool_bind_set_nl_policy        184    1480   +1296
    devlink_sb_tc_pool_bind_get_do_nl_policy     184    1480   +1296
    devlink_dpipe_table_get_nl_policy            240    1480   +1240
    devlink_dpipe_entries_get_nl_policy          240    1480   +1240
    devlink_dpipe_table_counters_set_nl_policy     272    1480   +1208
    devlink_eswitch_set_nl_policy                504    1480    +976
    devlink_resource_set_nl_policy               544    1480    +936
    devlink_param_get_do_nl_policy               656    1480    +824
    devlink_region_get_do_nl_policy              712    1480    +768
    devlink_region_new_nl_policy                 744    1480    +736
    devlink_region_del_nl_policy                 744    1480    +736
    devlink_health_reporter_test_nl_policy       928    1480    +552
    devlink_health_reporter_recover_nl_policy     928    1480    +552
    devlink_health_reporter_get_do_nl_policy     928    1480    +552
    devlink_health_reporter_dump_get_nl_policy     928    1480    +552
    devlink_health_reporter_dump_clear_nl_policy     928    1480    +552
    devlink_health_reporter_diagnose_nl_policy     928    1480    +552
    devlink_trap_get_do_nl_policy               1048    1480    +432
    devlink_trap_set_nl_policy                  1056    1480    +424
    devlink_trap_group_get_do_nl_policy         1088    1480    +392
    devlink_trap_policer_get_do_nl_policy       1144    1480    +336
    devlink_trap_group_set_nl_policy            1144    1480    +336
    devlink_trap_policer_set_nl_policy          1160    1480    +320
    devlink_port_set_nl_policy                  1168    1480    +312
    devlink_flash_update_nl_policy              1224    1480    +256
    devlink_reload_nl_policy                    1248    1480    +232
    devlink_port_new_nl_policy                  1320    1480    +160
    devlink_rate_get_do_nl_policy               1352    1480    +128
    devlink_rate_del_nl_policy                  1352    1480    +128
    devlink_linecard_get_do_nl_policy           1376    1480    +104
    __devlinks_xa_find_get                         -      96     +96
    devlink_linecard_set_nl_policy              1392    1480     +88
    devlink_selftests_run_nl_policy             1416    1480     +64
    devlink_get_from_attrs_lock                  262     314     +52
    devlink_region_read_nl_policy               1440    1480     +40
    devlink_rate_set_nl_policy                  1448    1480     +32
    devlink_rate_new_nl_policy                  1448    1480     +32
    devlinks_xa_lookup_get                         -      30     +30
    devlink_health_reporter_set_nl_policy       1456    1480     +24
    devlink_attr_index_range                       -      16     +16
    devlink_param_set_nl_policy                 1472    1480      +8
    devlink_nl_dumpit                            276     282      +6
    __initcall__kmod_core__670_573_devlink_init4       -       4      +4
    __initcall__kmod_core__670_561_devlink_init4       4       -      -4
    devlinks_xa_find_get                          96      24     -72
    Total: Before=5203976, After=5269704, chg +1.26%

> --- a/net/devlink/netlink_gen.c
> +++ b/net/devlink/netlink_gen.c
> @@ -11,6 +11,11 @@
>  
>  #include <uapi/linux/devlink.h>
>  
> +/* Integer value ranges */
> +static const struct netlink_range_validation devlink_attr_index_range = {
> +	.max	= U32_MAX,
> +};
> +
>  /* Sparse enums validation callbacks */
>  static int
>  devlink_attr_param_type_validate(const struct nlattr *attr,
> @@ -56,37 +61,42 @@ const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_I
>  };
>  
>  /* DEVLINK_CMD_GET - do */
> -static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
> +static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {

Unrelated to this change, but the explicit sizing of these arrays is not
needed, as the compiler will take care of that.

>  	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
> +	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),

This array, and many others below, are sparse, with large gaps (up to
1456 or 2912 bytes on 32-bit resp. 64-bit systems) before the last
entries.

>  };
>  
>  /* DEVLINK_CMD_PORT_GET - do */
> -static const struct nla_policy devlink_port_get_do_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
> +static const struct nla_policy devlink_port_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
>  	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
> +	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),

Shouldn't this be inserted at the end, as DEVLINK_ATTR_INDEX >
DEVLINK_ATTR_PORT_INDEX, for readability?

>  	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
>  };

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

