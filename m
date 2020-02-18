Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22C1626F3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBRNOI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 08:14:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42956 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgBRNOI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 08:14:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so10926631pgl.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 05:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jdlFIbfsKP8mpV1qIdh+maX5x9Py8knMFZVyrH1XVoY=;
        b=r2KIHcAQMiOsK8fNbAuDeNH+NDi44faCDe1ETHOAkCih4bDgDOx7Q6alTJyFttf80O
         cVnjVZFj1lwxhL12ojkDkoLYur2jQNmTeGnzuIJT8oQng8FFoWWNj0Bx8TQNwbGyJx1F
         SRXMOH/MrA5WFitQ6yyEtlghBpi5icxck2sduePCt+DEsxK8ADl3+c4vB+dsRofzwZia
         VEfYi8rUbYYXtu4xHjGcpazLpYMoY9r5TcMkJQ28JOLSayhTU0QNR23OEN1omDamyTBa
         o54qE3FAKrPIeusRChKzkQVIle8gFPgE8J1vHOhyhNblfGNgbpUA4irfCoDnuIAJzf63
         Mf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=jdlFIbfsKP8mpV1qIdh+maX5x9Py8knMFZVyrH1XVoY=;
        b=d/GWdDtepDU8IOQOWNV2D+/DpLj8aLccttCHS2oNEKddq2DH91EO7dJXi4yWqIoz9X
         C5mgFxfQU4ZCq2QY0xMbVNBM1ggMfeS9Uf4tY8jH/7kOfZXTgHJ65l8CNaePmjj29qRA
         90IqQ+uj9HMHyDAetys3i7rq2PMyvUf6yru3LbMvKA0yENjU+bhji75fdSyXCh3fapA6
         4HZ+Vv1mne04vf0zvswBlzn2Gl+zJ/4qDhSVyEFzmbVflnUP86AGTC3u0QX+vqk1ge6Q
         a39Fbrm7Hmh8QRLN7z4o+vLhjLkZvSFohYYFXY/qMYmVLCtUe6qwHriebUGaOrSLttj4
         gkcQ==
X-Gm-Message-State: APjAAAUqEIIQ49BaHgv/Ii527QK8UPU7zTLWauss0Z82Dvs/wjcQbd8t
        JLPZGerRGi4zfTLOQ/uYUjn282LA
X-Google-Smtp-Source: APXvYqwItj+GfdTAMlFOhl3heEEEdyxnfXYeseQTziPX5/XmVF4j25P7692UJaJPpGNxPWxViNqcFw==
X-Received: by 2002:a63:348b:: with SMTP id b133mr23036514pga.372.1582031647766;
        Tue, 18 Feb 2020 05:14:07 -0800 (PST)
Received: from [0.0.0.0] ([2001:19f0:6001:4f1d:5400:2ff:fe84:20ce])
        by smtp.googlemail.com with ESMTPSA id y10sm4442408pfq.110.2020.02.18.05.14.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 05:14:07 -0800 (PST)
To:     linux-rdma@vger.kernel.org
From:   zerons <sironhide0null@gmail.com>
Subject: Maybe a race condition in net/rds/rdma.c?
Openpgp: preference=signencrypt
Message-ID: <afd9225d-5c43-8cc7-0eed-455837b53e10@gmail.com>
Date:   Tue, 18 Feb 2020 21:13:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, all

In net/rds/rdma.c
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/rds/rdma.c?h=v5.5.3#n419),
there may be a race condition between rds_rdma_unuse() and rds_free_mr().

It seems that this one need some specific devices to run test,
unfortunately, I don't have any of these.
I've already sent two emails to the maintainer for help, no response yet,
(the email address may not be in use).

0) in rds_recv_incoming_exthdrs(), it calls rds_rdma_unuse() when receive an
extension header with force=0, if the victim mr does not have RDS_RDMA_USE_ONCE
flag set, then the mr would stay in the rbtree. Without any lock, it tries to
call mr->r_trans->sync_mr().

1) in rds_free_mr(), the same mr is found, and then freed. The mr->r_refcount
doesn't change while rds_mr_tree_walk().

0) back in rds_rdma_unuse(), the victim mr get used again, call
mr->r_trans->sync_mr().

Could this race condition actually happen?

Thank you.
