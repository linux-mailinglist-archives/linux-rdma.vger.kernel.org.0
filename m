Return-Path: <linux-rdma+bounces-13921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71355BE74CC
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 10:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AA4EAD00
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A12641FB;
	Fri, 17 Oct 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2QSAupc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F225F984
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691254; cv=none; b=I4+/V1ZK+vHiXVvBdyAPNxjkWq2D75Fm6aurfHMxd6od20hgIF1ZDsRur6DwJrYm71/RjylCb5MmvGUQ7DtfrJyX4u4GecdUcKNLvRJ3ww3Yu6Ps/Lqrwry64BW7Gmzcw7S7jfBOd1Sk5NdrLSz+oIniLL6G0VUifzBMzoZzHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691254; c=relaxed/simple;
	bh=eem6S4uznmDodIVKznOnMgO441t1mPGx/mWxdXYYBq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QTTKC8CdYG11hUo/IM4/3Qhv12/ZXtBOXI4eIxflP3Ci4ee2uAdmO8HL/xXB0HFA1eL30Z0QseBPMu9CHiHhdC8SNWZkwYdd6iItTOpaXsDBbrMu+4pUYZksfYZd6hYOXHAGvrCaiYf0cNsdwgJ+bpd00b5ow5rzf/qv+i4cM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2QSAupc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710683a644so15369035e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760691247; x=1761296047; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNwG8uZxAvU7ZJj1H2XH8S8Em7ssaukgM09b5ajxMxI=;
        b=g2QSAupcpkdWxwD7KTvY3SBp/333BuDqOaC2TYSA6vBaXYPvgQZ1Cb7JOofJMjAbGR
         ZgM13Pi+TtK7MkorEhfiH/NRABdl3lzpYfTC0f09l7FV/UE2gqEoi1NwyNnrkQ1TPths
         qljOVXbGnrgIkQsKyG3v4FE8f6jEsufRqarxyA3CpmQN5fmaDAfJqBRHdSuK+GLa0TlH
         gehaV+bnMeVd+5sYYpmlVzl+6J3+o9lSZ4gHn2qNqiUS/EKdKEQ2scGdrsmZqGqj0DIv
         +rqQGvXJ0ojkOdXquNWJB3rWIvEIE53Ch5ptRIiBgw/4moRsZJpZwnOwO693KPz/V0fa
         B6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691247; x=1761296047;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNwG8uZxAvU7ZJj1H2XH8S8Em7ssaukgM09b5ajxMxI=;
        b=avFctTpk3nL0Q1UfYkJMkc3HtebeNBvMu5mEGJ1oNOgqOoeC/4z4e5cL2uvIWbthlX
         dBUxFZgpEo9GtzgfBqygBhAbrDC59lZMBEupSULZ071uw2oBVWkFy107fNHimSjargME
         5WOgb//v6SK9JYjytSj1paGGiNYGwM787h1vzdB/FbPyaYiZzecCgT60yVKwYQ2x8dw9
         PjmN3+dsv6qJlWFSVGIAgSR91kWowoohVPo3R2pKiJX3YjLuipokcRjAZOZdiZ/L4/e7
         HY3U2sXbvF/w2gOcDCTvZTonDILzRD7vt2WcqIQq4dPzCu4YCSrumbanwb2gPtUjxaTm
         MdqQ==
X-Gm-Message-State: AOJu0YyGIpudDEZ7SxucxWvbDHSGqEFb6E2tqnrFokm0h+5+7Qi6P6cE
	1dl4hhkKe6Fwod14yiXntxUHAbk+uGynZQ6zg06yK4AkchmNHHGrV92050HnUWA++pC/vT5kBxA
	9zxLp
X-Gm-Gg: ASbGnct2ECiVO1Atb3VQx0FW9yeXrbsLg80w1gU7RTWGcBphXmOJAqe+u8lYYc5SdeR
	CqwMSi2YIBLj/s8/LEWtFlvaOmNWzQ1UvP/q7UMJ2dP1bactyLGngEVp1O555sdGY+7oKo1U0it
	YFxsGpv478hrAJt+nyuR0+Q1wZmFXWSqCw5LJJAmebPpIPw/qd8NDoBtkxeFjWU/nJli2HtTikS
	hohLiaj1ZpU4tAYkHUcw1l0gW+z/Ubzb893h+6xmlVTBO6RQ/8m70LenOpkGi1bjehjRQtj+3Bb
	mcUZAKPB34FN1reznoWuoyzW0l7G8sEeYTh0f0MP8VAADufGyWi07XsVN4WyzEhLQKbExgixIQE
	+YqxLla1EtVzNTuMxv8FqIAhe6zxyDhEmrTDQ1zU0CvspX0RqWVMjxh00j2lS3wUO6/4klqJFNW
	A4Ug97/hHLvBO7sHYD
X-Google-Smtp-Source: AGHT+IH0B/WIlgk7Eb0PE46daVnVrXFt+y2xzI4kbeUhxRRqsxOEJTeAr1m7OkHB3kKXccGxCEJATw==
X-Received: by 2002:a05:600c:6290:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47117345ffdmr26967765e9.19.1760691247246;
        Fri, 17 Oct 2025 01:54:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42704141cc3sm6159652f8f.9.2025.10.17.01.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:54:06 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:54:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Prevent tunnel reformat when tunnel mode not
 allowed
Message-ID: <aPIEK4rLB586FdDt@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Carolina Jubran,

Commit 22239eb258bc ("net/mlx5e: Prevent tunnel reformat when tunnel
mode not allowed") from Oct 5, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:808 mlx5e_xfrm_add_state()
	warn: missing error code 'err'

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
    770 static int mlx5e_xfrm_add_state(struct net_device *dev,
    771                                 struct xfrm_state *x,
    772                                 struct netlink_ext_ack *extack)
    773 {
    774         struct mlx5e_ipsec_sa_entry *sa_entry = NULL;
    775         bool allow_tunnel_mode = false;
    776         struct mlx5e_ipsec *ipsec;
    777         struct mlx5e_priv *priv;
    778         gfp_t gfp;
    779         int err;
    780 
    781         priv = netdev_priv(dev);
    782         if (!priv->ipsec)
    783                 return -EOPNOTSUPP;
    784 
    785         ipsec = priv->ipsec;
    786         gfp = (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ) ? GFP_ATOMIC : GFP_KERNEL;
    787         sa_entry = kzalloc(sizeof(*sa_entry), gfp);
    788         if (!sa_entry)
    789                 return -ENOMEM;
    790 
    791         sa_entry->x = x;
    792         sa_entry->dev = dev;
    793         sa_entry->ipsec = ipsec;
    794         /* Check if this SA is originated from acquire flow temporary SA */
    795         if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
    796                 goto out;
    797 
    798         err = mlx5e_xfrm_validate_state(priv->mdev, x, extack);
    799         if (err)
    800                 goto err_xfrm;
    801 
    802         if (!mlx5_eswitch_block_ipsec(priv->mdev)) {
    803                 err = -EBUSY;
    804                 goto err_xfrm;
    805         }
    806 
    807         if (mlx5_eswitch_block_mode(priv->mdev))
--> 808                 goto unblock_ipsec;

Should we set the error code on this path?  err = -EINVAL?  If not the
way to silence these warnings would be to set "ret = 0;" within five
lines of the goto.  (The compiler will obviously remove that, it's just
for the checker and human readers).  Another option would be to add a
comment.

    809 
    810         if (x->props.mode == XFRM_MODE_TUNNEL &&
    811             x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
    812                 allow_tunnel_mode = mlx5e_ipsec_fs_tunnel_allowed(sa_entry);
    813                 if (!allow_tunnel_mode) {
    814                         NL_SET_ERR_MSG_MOD(extack,
    815                                            "Packet offload tunnel mode is disabled due to encap settings");
    816                         err = -EINVAL;
    817                         goto unblock_mode;
    818                 }
    819         }
    820 
    821         /* check esn */
    822         if (x->props.flags & XFRM_STATE_ESN)
    823                 mlx5e_ipsec_update_esn_state(sa_entry);
    824         else
    825                 /* According to RFC4303, section "3.3.3. Sequence Number Generation",
    826                  * the first packet sent using a given SA will contain a sequence
    827                  * number of 1.
    828                  */
    829                 sa_entry->esn_state.esn = 1;
    830 
    831         mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, &sa_entry->attrs);
    832 
    833         err = mlx5_ipsec_create_work(sa_entry);
    834         if (err)
    835                 goto unblock_encap;
    836 
    837         err = mlx5e_ipsec_create_dwork(sa_entry);
    838         if (err)
    839                 goto release_work;
    840 
    841         /* create hw context */
    842         err = mlx5_ipsec_create_sa_ctx(sa_entry);
    843         if (err)
    844                 goto release_dwork;
    845 
    846         err = mlx5e_accel_ipsec_fs_add_rule(sa_entry);
    847         if (err)
    848                 goto err_hw_ctx;
    849 
    850         /* We use *_bh() variant because xfrm_timer_handler(), which runs
    851          * in softirq context, can reach our state delete logic and we need
    852          * xa_erase_bh() there.
    853          */
    854         err = xa_insert_bh(&ipsec->sadb, sa_entry->ipsec_obj_id, sa_entry,
    855                            GFP_KERNEL);
    856         if (err)
    857                 goto err_add_rule;
    858 
    859         mlx5e_ipsec_set_esn_ops(sa_entry);
    860 
    861         if (sa_entry->dwork)
    862                 queue_delayed_work(ipsec->wq, &sa_entry->dwork->dwork,
    863                                    MLX5_IPSEC_RESCHED);
    864 
    865         if (allow_tunnel_mode) {
    866                 xa_lock_bh(&ipsec->sadb);
    867                 __xa_set_mark(&ipsec->sadb, sa_entry->ipsec_obj_id,
    868                               MLX5E_IPSEC_TUNNEL_SA);
    869                 xa_unlock_bh(&ipsec->sadb);
    870         }
    871 
    872 out:
    873         x->xso.offload_handle = (unsigned long)sa_entry;
    874         if (allow_tunnel_mode)
    875                 mlx5_eswitch_unblock_encap(priv->mdev);
    876 
    877         mlx5_eswitch_unblock_mode(priv->mdev);
    878 
    879         return 0;
    880 
    881 err_add_rule:
    882         mlx5e_accel_ipsec_fs_del_rule(sa_entry);
    883 err_hw_ctx:
    884         mlx5_ipsec_free_sa_ctx(sa_entry);
    885 release_dwork:
    886         kfree(sa_entry->dwork);
    887 release_work:
    888         if (sa_entry->work)
    889                 kfree(sa_entry->work->data);
    890         kfree(sa_entry->work);
    891 unblock_encap:
    892         if (allow_tunnel_mode)
    893                 mlx5_eswitch_unblock_encap(priv->mdev);
    894 unblock_mode:
    895         mlx5_eswitch_unblock_mode(priv->mdev);
    896 unblock_ipsec:
    897         mlx5_eswitch_unblock_ipsec(priv->mdev);
    898 err_xfrm:
    899         kfree(sa_entry);
    900         NL_SET_ERR_MSG_WEAK_MOD(extack, "Device failed to offload this state");
    901         return err;
    902 }

regards,
dan carpenter

