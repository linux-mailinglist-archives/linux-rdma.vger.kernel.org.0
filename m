Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0324F576
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgHXItS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 04:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgHXItQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 04:49:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E87F206F0;
        Mon, 24 Aug 2020 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258956;
        bh=XQl4BP6c+Me3OHxY2E47y0b6uJWoZkbAiDuHUy1Fcog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRA4f6+92i6b6ixmxKBN5kmyzfDvnxQb4r1Lf8NSo2yCxDqJenpy3dxp93X7btZyG
         0//kBWcTncEeQ/n4TxiTbdAmul8inxXUUDwztitbBHHRTlL9p4qERTlwo5YWUkhXaZ
         +ZQrt+xXzd7G0HJ5lSQhG4hC66h47zzY/pyufYiQ=
Date:   Mon, 24 Aug 2020 11:49:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: a run_tests question
Message-ID: <20200824084912.GH571722@unreal>
References: <f3e03ee0-74e7-779d-ad89-91e7835178b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e03ee0-74e7-779d-ad89-91e7835178b9@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 21, 2020 at 05:46:46PM -0500, Bob Pearson wrote:
> I think I figured out why the create/destroy_ah test cases are failing for rxe.
> The test_addr.py test uses sgid_index = 0 which is supposed to "always work", but when the device is created the rdma core fills in the first entry with the link local IPV6 address based on the port guid which is the swizzled MAC address.
>
> This doesn't match any of the interface addresses. Once RC traffic has passed the address gets replaced with a 'better' address and create_ah works. The test runs of you just pick sgid_index = 1 instead. This behavior is determined by the core not the driver. The driver doesn't manage the gid table AFAIK.

So what is the question?
