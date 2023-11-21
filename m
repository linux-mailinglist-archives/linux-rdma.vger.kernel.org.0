Return-Path: <linux-rdma+bounces-2-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F17F22B6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 02:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AE328195C
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 01:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8A17EE;
	Tue, 21 Nov 2023 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xBjaObt6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610E17CA
	for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 01:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F490C433C7;
	Tue, 21 Nov 2023 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700528435;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=xBjaObt6ZlgC7IjQfwLlun2lQ5wF0k6A6iXDWXXbEqGzFGNMOPELaSAUKQqtJTyMc
	 WfwoR6AaQYoIqdNVR8mDRQhb5vj4sMEgrxCz2xh8g9xEJoyCBCsTvoQ1epZfJDuiMU
	 DH1g2IWfzxkv+f7mCV9NlqgewnDcQoIxXFZy/j80=
Date: Mon, 20 Nov 2023 20:00:34 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-rdma@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-outstanding-adamant-toucan-23c5f2@nitro>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

