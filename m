Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3DFE244
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 17:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfKOQH2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 11:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfKOQH2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Nov 2019 11:07:28 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3897E20730;
        Fri, 15 Nov 2019 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573834047;
        bh=iNgpsCFUH8rnEqS8OXF0UPo2llC7V1SQtR4fJ9HHdrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qH5RZwSMdd9Dq0kUbE6ZmmBx6Kl9VZxQA6EDrmTJDu3eKIoATZY7uOmZ1KuVsoChv
         F4PBIncHQJZIO5Z3xh9jIVrLkBIgszjvJbzg/eEuFsNYrpDxQ6nYO+BtNKDZqWEa6e
         085DZi0xeuuwk7QnMn2he7Muv+zTDN2ixjE9GN7g=
Date:   Fri, 15 Nov 2019 18:07:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     QWang <3100102071@zju.edu.cn>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Why our soft-RoCE throughput is quite low compared with TCP
Message-ID: <20191115160707.GG6763@unreal>
References: <f97b72b6-4def-2970-c9f6-f11b97d5378e@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f97b72b6-4def-2970-c9f6-f11b97d5378e@zju.edu.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 15, 2019 at 09:26:41PM +0800, QWang wrote:
> Dear experts on RDMA,
>       We are sorry to disturb you. Because of a project, we need to
> integrate soft-RoCE in our system. However ,we are very confused by our
> soft-RoCE throughput results, which are quite low compared with TCP
> throughput. The throughput of soft-RoCE in our tests measured by ib_send_bw
> and ib_read_bw is only 2 Gbps (the net link bandwidth is 100 Gbps and the
> two Xeon E5 servers with Mellanox ConnectX-4 cards are connected via
> back-to-back, the OS is ubuntu16.04 with kernel 4.15.0-041500-generic). The
> throughput of hard-RoCE and TCP are normal, which are 100 Gbps and 20 Gbps,
> respectively. But in the figure 6 in the attached paper "A Performance
> Comparison of Container Networking Alternatives", the throughput of
> soft-RoCE can be up to 23 Gbps.  In our tests, we get the open-source
> soft-RoCE from github in https://github.com/linux-rdma. Do you know how can
> we get such high bandwidth? Do we need to configure some OS system settings?
>       We find that in 2017, someone finds the same problem and he posts all
> his detailed results on https://bugzilla.kernel.org/show_bug.cgi?id=190951  
> . But it remains unsolved. His results are nearly the same with our's. For
> simplicity,  we do not post our results in this email. You can get very
> detailed information in the web page listed above.
>       We are very confused by our results. We will very appreciate it if we
> can receive your early reply. Best wishes,
> Wang Qi

Can you please fix your email client?
The email text looks like one big sentence.

From the perf report attached to this bugzilla, looks like RXE does a
lot of CRC32 calculations and it is consistent with what Matan said
a long time ago, RXE "stuck" in ICRC calculations required by spec.

I'm curios what are your CONFIG_CRYPTO_* configs?

Thanks

>
