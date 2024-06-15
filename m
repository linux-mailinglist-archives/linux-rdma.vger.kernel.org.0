Return-Path: <linux-rdma+bounces-3154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27909094F1
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 02:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302E3B21239
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 00:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65B10E9;
	Sat, 15 Jun 2024 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0MSXZg8C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E28623
	for <linux-rdma@vger.kernel.org>; Sat, 15 Jun 2024 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718409953; cv=none; b=RIQld7SqDbxIGbbUnAfRv/F37GxAo8gMAzeZA5cJeM/mCvj0S5SZjgImJJyK45PrHyHp4FklC6b1gR2srBv2+Rhxdm5EwR5mlcYe6qE+6aCN6gFBrfs53wnlWHihMOWPf8rg/usiPpOzMG+F/z2RqSpdtXO/RfmHF1ty6JJ3e4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718409953; c=relaxed/simple;
	bh=f6AoYhX2XyzT+ZH0EktrmSnDM4D3zhudlPqVu/nrjns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtsGowp6eaT9osFh2Qqk7NbZuSS6HUYfQ9rjIrp5vxQP4PuAgPF8I6bXU2gXe/WlhUZs9boo73EXdxeSuRNxPvzByvmpEsTkOfPNOBtTjknoQFIyA+QKKUwXQB3GsieLVJGXGcvf0BVvlBgnbwSINothFHEw1Ix/6j0+EsPmOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0MSXZg8C; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso2267549a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2024 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1718409951; x=1719014751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c21Xnr26mF4XhO4v24lG8CYkDryUnaevoVevI7wRSgQ=;
        b=0MSXZg8CqtR1DAOlvKfLZM5qykyu832wLgqtz53yfABK2/qNcNy6klqSu/6+KihLGe
         SEF/F1BThMGlrBM8bkr/I5yEYHprNTwNzugD+WoXvVzuFeDMf4NX/CeaIuRajcheefX8
         MHthXF23rggit3Hgox1mW1VqqIHg5nsW4F4RcOLSY8b3F6JdGtJ5GnkQitlZhuj3AmBD
         3BcRExcb09vADiQtEQert2rhbC5dPW7o3RequLC3g/3J32QxmHs52WAwB9FATzIuAjLc
         Sx1cXqpyQ/ICGkpn/jfoC2CbTI76TOgCqupwT7mjZugX8fwJbi55l9NbA4kHtZ2S+AoS
         3yGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718409951; x=1719014751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c21Xnr26mF4XhO4v24lG8CYkDryUnaevoVevI7wRSgQ=;
        b=aGF/uDGOfqd1/C/p++T2RyIYa4W7fOusPFimNmzV/eyFBD4onA/TjqI2ZzWOnmMFut
         gpJVMR/HeGsBSAV6cMzdcb1nOYDunVnaVHEFVqkfA/lSZct0WpvzwSedevvNyikB1y0p
         L16wnuuBi34JUZHKcOoSy7KNmiJeF9NLlBkUXISL3WEBdIxK56Cy+cm1XbFXr76+Wfl0
         ZCTu4diBYhrlCKPM2Hrgm3v0evxjBw0NXQ6XI38OFg2v8AN75H1STgZCO15rAHNvKwjv
         SQsiiEwqelx2yecle3010z5VAYFEGmkmAXcKCZoVsoPghLUpafDRbUhE/9UgTqFSydjl
         LZpA==
X-Forwarded-Encrypted: i=1; AJvYcCVZLtCa7L8RvV6R+LejfttgLo2FQtYkp4lDKUHJOd+bAsJpTJRdDGEUksnXiRSh92353Mv4J62qZj+QImbeBXkU3Jj91STBDLy3GA==
X-Gm-Message-State: AOJu0YwELf7L6nK0cAjVaMFH3hELBG4xeEt86xVXE0+1hcL5nYOOqt+J
	g3OQ8yZAnuZU4tZG4md1b+ZTfEOG5ep5IDj7y2DFBIY+ISJljE3n59NzH8ZoOFk=
X-Google-Smtp-Source: AGHT+IHET3q/ZWVI0gCLmEytjo+qe1Q0o8W6KZxsgsqtRPqlyJa6ges0MNDa6YBygs6HHNzj/wFOeQ==
X-Received: by 2002:a17:903:1250:b0:1f7:2050:9a76 with SMTP id d9443c01a7336-1f8625c0d68mr49770465ad.8.1718409950685;
        Fri, 14 Jun 2024 17:05:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f17f92sm37976575ad.221.2024.06.14.17.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 17:05:50 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:05:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ogabbay@kernel.org, zyehudai@habana.ai
Subject: Re: [PATCH 01/15] net: hbl_cn: add habanalabs Core Network driver
Message-ID: <20240614170548.188ead0d@hermes.local>
In-Reply-To: <20240613082208.1439968-2-oshpigelman@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
	<20240613082208.1439968-2-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> +#define HBL_AUX2NIC(aux_dev)	\
> +	({ \
> +		struct hbl_aux_dev *__aux_dev = (aux_dev); \
> +		((__aux_dev)->type == HBL_AUX_DEV_ETH) ? \
> +		container_of(__aux_dev, struct hbl_cn_device, en_aux_dev) : \
> +		container_of(__aux_dev, struct hbl_cn_device, ib_aux_dev); \
> +	})
> +
> +#define RAND_STAT_CNT(cnt) \
> +	do { \
> +		u32 __cnt = get_random_u32(); \
> +		(cnt) = __cnt; \
> +		dev_info(hdev->dev, "port %d, %s: %u\n", port, #cnt, __cnt); \
> +	} while (0)
> +
> +struct hbl_cn_stat hbl_cn_mac_fec_stats[] = {
> +	{"correctable_errors", 0x2, 0x3},
> +	{"uncorrectable_errors", 0x4, 0x5}
> +};
> +

These tables should be marked const?

> +struct hbl_cn_stat hbl_cn_mac_stats_rx[] = {
> +	{"Octets", 0x0},
> +	{"OctetsReceivedOK", 0x4},
> +	{"aAlignmentErrors", 0x8},
> +	{"aPAUSEMACCtrlFramesReceived", 0xC},
> +	{"aFrameTooLongErrors", 0x10},
> +	{"aInRangeLengthErrors", 0x14},
> +	{"aFramesReceivedOK", 0x18},
> +	{"aFrameCheckSequenceErrors", 0x1C},
> +	{"VLANReceivedOK", 0x20},
> +	{"ifInErrors", 0x24},
> +	{"ifInUcastPkts", 0x28},
> +	{"ifInMulticastPkts", 0x2C},
> +	{"ifInBroadcastPkts", 0x30},
> +	{"DropEvents", 0x34},
> +	{"Pkts", 0x38},
> +	{"UndersizePkts", 0x3C},
> +	{"Pkts64Octets", 0x40},
> +	{"Pkts65to127Octets", 0x44},
> +	{"Pkts128to255Octets", 0x48},
> +	{"Pkts256to511Octets", 0x4C},
> +	{"Pkts512to1023Octets", 0x50},
> +	{"Pkts1024to1518Octets", 0x54},
> +	{"Pkts1519toMaxOctets", 0x58},
> +	{"OversizePkts", 0x5C},
> +	{"Jabbers", 0x60},
> +	{"Fragments", 0x64},
> +	{"aCBFCPAUSERx0", 0x68},
> +	{"aCBFCPAUSERx1", 0x6C},
> +	{"aCBFCPAUSERx2", 0x70},
> +	{"aCBFCPAUSERx3", 0x74},
> +	{"aCBFCPAUSERx4", 0x78},
> +	{"aCBFCPAUSERx5", 0x7C},
> +	{"aCBFCPAUSERx6", 0x80},
> +	{"aCBFCPAUSERx7", 0x84},
> +	{"aMACControlFramesReceived", 0x88}
> +};
> +
> +struct hbl_cn_stat hbl_cn_mac_stats_tx[] = {
> +	{"Octets", 0x0},
> +	{"OctetsTransmittedOK", 0x4},
> +	{"aPAUSEMACCtrlFramesTransmitted", 0x8},
> +	{"aFramesTransmittedOK", 0xC},
> +	{"VLANTransmittedOK", 0x10},
> +	{"ifOutErrors", 0x14},
> +	{"ifOutUcastPkts", 0x18},
> +	{"ifOutMulticastPkts", 0x1C},
> +	{"ifOutBroadcastPkts", 0x20},
> +	{"Pkts64Octets", 0x24},
> +	{"Pkts65to127Octets", 0x28},
> +	{"Pkts128to255Octets", 0x2C},
> +	{"Pkts256to511Octets", 0x30},
> +	{"Pkts512to1023Octets", 0x34},
> +	{"Pkts1024to1518Octets", 0x38},
> +	{"Pkts1519toMaxOctets", 0x3C},
> +	{"aCBFCPAUSETx0", 0x40},
> +	{"aCBFCPAUSETx1", 0x44},
> +	{"aCBFCPAUSETx2", 0x48},
> +	{"aCBFCPAUSETx3", 0x4C},
> +	{"aCBFCPAUSETx4", 0x50},
> +	{"aCBFCPAUSETx5", 0x54},
> +	{"aCBFCPAUSETx6", 0x58},
> +	{"aCBFCPAUSETx7", 0x5C},
> +	{"aMACControlFramesTx", 0x60},
> +	{"Pkts", 0x64}
> +};
> +
> +static const char pcs_counters_str[][ETH_GSTRING_LEN] = {
> +	{"pcs_local_faults"},
> +	{"pcs_remote_faults"},
> +	{"pcs_remote_fault_reconfig"},
> +	{"pcs_link_restores"},
> +	{"pcs_link_toggles"},
> +};
> +
> +static size_t pcs_counters_str_len = ARRAY_SIZE(pcs_counters_str);
> +size_t hbl_cn_mac_fec_stats_len = ARRAY_SIZE(hbl_cn_mac_fec_stats);
> +size_t hbl_cn_mac_stats_rx_len = ARRAY_SIZE(hbl_cn_mac_stats_rx);
> +size_t hbl_cn_mac_stats_tx_len = ARRAY_SIZE(hbl_cn_mac_stats_tx);
> +
> +static void qps_stop(struct hbl_cn_device *hdev);
> +static void qp_destroy_work(struct work_struct *work);
> +static int __user_wq_arr_unset(struct hbl_cn_ctx *ctx, struct hbl_cn_port *cn_port, u32 type);
> +static void user_cq_destroy(struct kref *kref);
> +static void set_app_params_clear(struct hbl_cn_device *hdev);
> +static int hbl_cn_ib_cmd_ctrl(struct hbl_aux_dev *aux_dev, void *cn_ib_ctx, u32 op, void *input,
> +			      void *output);
> +static int hbl_cn_ib_query_mem_handle(struct hbl_aux_dev *ib_aux_dev, u64 mem_handle,
> +				      struct hbl_ib_mem_info *info);
> +
> +static void hbl_cn_reset_stats_counters_port(struct hbl_cn_device *hdev, u32 port);
> +static void hbl_cn_late_init(struct hbl_cn_device *hdev);
> +static void hbl_cn_late_fini(struct hbl_cn_device *hdev);
> +static int hbl_cn_sw_init(struct hbl_cn_device *hdev);
> +static void hbl_cn_sw_fini(struct hbl_cn_device *hdev);
> +static void hbl_cn_spmu_init(struct hbl_cn_port *cn_port, bool full);
> +static int hbl_cn_cmd_port_check(struct hbl_cn_device *hdev, u32 port, u32 flags);
> +static void hbl_cn_qps_stop(struct hbl_cn_port *cn_port);

Can you reorder code so forward declarations are not required?

