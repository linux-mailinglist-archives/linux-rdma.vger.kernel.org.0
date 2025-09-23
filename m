Return-Path: <linux-rdma+bounces-13595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6401B96156
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A0B2E694C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C445020125F;
	Tue, 23 Sep 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm+Z1JxZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DACC1FBC8E
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635426; cv=none; b=jfuok/ElxTYPhxBhWBL0bPK8gAo0FBCc04wIsmF30v5hDVaiamrSsgxKc9leLyc6NsNvNCakPKiJR5VtM49yRoCdLjeBP3i/6Sv+j7ARVm4oC0IhjtISmqxaLllvj7AejPIT4Vj2i3riwBXy1oRD9Gzi4USd+Z82zwprk9kuj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635426; c=relaxed/simple;
	bh=juYoxKaRkTLnK1DpkN8BkFWYf8GgON63AQ8F8AdJ/As=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cimAHkv0e4z1LOENncqEhtjlLn2eZ1LV6/6Cwm6H1JSlMTn+Ae63DFcysHn0S5/qoYNLpBelpocmrz+Wr8/ffoBl6mH20IfMsSWhsc55RLGPyib7q07v9DkNRAcv5Ux53Rb4Mhupr0NqzZphFPap+q/tJAd2azCFT0kaPysJPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cm+Z1JxZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f2ae6fae12so2086808f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758635423; x=1759240223; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44yHdtpo9L92TZ5YA23FEmdXDKmIU+Mf3IegCCwA7bU=;
        b=cm+Z1JxZxPBzd5SCc5RIoHrQNojklQBRHBxZK2TYCRp0TssrIXrjgijHrXYa9tXhO+
         iqbhNAQhIYGKMot1o5B8HycpmTwVFuBs43BBtRrhXpqhly9Go96yLO+qS3Og4jt89ZSt
         FdtvN0/Ec+EUdGYYhEtPJTAWFPZ+8JtzRiSO8KUteo/Trr+/+1Iq2f54+wB2cXYss3x/
         CvdTalUlYXEWRslYaxzT09OEY6CxkLUDjc7LTA1L/TmQUiVj/MIokQrrxkRk6VgLiHen
         r9YYINCWBgZbFTZNEbw28iZNiqyPej3FGKc5FXwEwNWYuB5kSdivXfeaLBv6734hTDar
         kK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635423; x=1759240223;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44yHdtpo9L92TZ5YA23FEmdXDKmIU+Mf3IegCCwA7bU=;
        b=HgRRzVzhUBTnKZ79F2XIzchULVjHc4KVgv1RMFtolu94vQ3z3qNXy8NM/NO4lBioGG
         Wg39AU/SKaYGVjoC4SsS/5LTsvZN29ZMMN71bgDEHkb7iSD3y7S2bE9ABAA5mKxqAuXp
         Hdek6OozVLaPom4AFuv42qtvkcJ2/mhYwRATFHo5xAISWktyxrfVZmkXbfGEUDILJPZS
         9WiybRIQ/BwumQIlqJespsvJs7Oif2Bcw5VslmtKXi2rRfYQixngRultXG96QT9olwlZ
         Y7LduFhMpz2VzX2x/OaNKqX9HliIvDhdGKOEJfLKm13GE2T0MpRsw9iQ6Tk7TB9g6GMM
         bTQg==
X-Gm-Message-State: AOJu0YwdWteojpQUoBbuBVO1dR156p/frCE/HjEfLTizgEDmSViJQjvd
	k8v8TJpAsoFvFvmB1sx/dbQxM594GD2PJn10JIvaN+dGPKFa8hAhzZQV4jZKFhgHXRw=
X-Gm-Gg: ASbGnctyn3YorqkNE9kF3MB7Pkl4RZpOm43+t3wmXoJg6LxJI4llcF5ycZeFDifc7V6
	HhyupfxXssm8aY9agNqcXHqAOBIim9x+vGKf2qqNBhSSXoqbxh4di/o2i7FNwL/btWJXzhYOyel
	Wsz3UuctyPR6oWwpJ+WbUzsJsSFdTfeH78OTCKB866fb1z9xDVbpNeOxGoIE2qQnOcDY212e1ol
	Iw6Kgxg2vb1BOBb78CItns8DIamOk3nC8MXt5b8eK/0E2EiQOdePoZCOJgy/kle0KqCk3KgbGyP
	IQseu6arM2QC13QEAEEo2yLaeem0hwDY//AFTne1lhrVO4X3WKkzDXEqnhNE84nf08j977WYZtl
	LTe4EFz5c9VzvSdG5a3k1WgqoH8Ar
X-Google-Smtp-Source: AGHT+IEwQErGwbsiylhWDq8xZgZ9sFwEvcvU4M+A1GXjAHbtbB7Iv9M0bR3IeUouGt3Vm7UiF1+NQQ==
X-Received: by 2002:a5d:5f92:0:b0:3ee:d165:2edd with SMTP id ffacd0b85a97d-405c551b846mr2218319f8f.28.1758635422755;
        Tue, 23 Sep 2025 06:50:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3f99178390csm11416267f8f.44.2025.09.23.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:50:22 -0700 (PDT)
Date: Tue, 23 Sep 2025 16:50:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Raed Salem <raeds@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Implement PSP Tx data path
Message-ID: <aNKlmnAdq34R9WSt@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Raed Salem,

Commit e5a1861a298e ("net/mlx5e: Implement PSP Tx data path") from
Sep 16, 2025 (linux-next), leads to the following Smatch static
checker warning:

    drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:1012 mlx5i_sq_xmit()
    error: NULL dereference inside function 'mlx5e_txwqe_build_eseg_csum()'

    drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:143 mlx5e_txwqe_build_eseg_csum()
    warn: variable dereferenced before check 'accel' (see line 125)

drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
    978 void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
    979                    struct mlx5_av *av, u32 dqpn, u32 dqkey, bool xmit_more)
    980 {
    981         struct mlx5e_tx_wqe_attr wqe_attr;
    982         struct mlx5e_tx_attr attr;
    983         struct mlx5i_tx_wqe *wqe;
    984 
    985         struct mlx5_wqe_datagram_seg *datagram;
    986         struct mlx5_wqe_ctrl_seg *cseg;
    987         struct mlx5_wqe_eth_seg  *eseg;
    988         struct mlx5_wqe_data_seg *dseg;
    989         struct mlx5e_tx_wqe_info *wi;
    990 
    991         struct mlx5e_sq_stats *stats = sq->stats;
    992         int num_dma;
    993         u16 pi;
    994 
    995         mlx5e_sq_xmit_prepare(sq, skb, NULL, &attr);
    996         mlx5i_sq_calc_wqe_attr(skb, &attr, &wqe_attr);
    997 
    998         pi = mlx5e_txqsq_get_next_pi(sq, wqe_attr.num_wqebbs);
    999         wqe = MLX5I_SQ_FETCH_WQE(sq, pi);
    1000 
    1001         stats->xmit_more += xmit_more;
    1002 
    1003         /* fill wqe */
    1004         wi       = &sq->db.wqe_info[pi];
    1005         cseg     = &wqe->ctrl;
    1006         datagram = &wqe->datagram;
    1007         eseg     = &wqe->eth;
    1008         dseg     =  wqe->data;
    1009 
    1010         mlx5i_txwqe_build_datagram(av, dqpn, dqkey, datagram);
    1011 
--> 1012         mlx5e_txwqe_build_eseg_csum(sq, skb, NULL, eseg);
                                                      ^^^^
The patch adds an unchecked dereference of this NULL pointer.  There are
other callers as well.

    1013 
    1014         eseg->mss = attr.mss;
    1015 
    1016         if (attr.ihs) {
    1017                 if (unlikely(attr.hopbyhop)) {

regards,
dan carpenter

