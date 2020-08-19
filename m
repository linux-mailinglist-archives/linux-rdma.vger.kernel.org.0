Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9324944E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 07:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbgHSFCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Aug 2020 01:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSFCH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Aug 2020 01:02:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08FC2078D;
        Wed, 19 Aug 2020 05:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597813327;
        bh=JaVUsKMtSLjB5p7XQP1YY9obeTIxr1dSRsPE9njncoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7aebWsSASIWPt6KScLZD1BZ0y95+M0JWv4qDMj2RJKhQX6tDV5IgZVxU0oXgsd6T
         SBkZmmdi0eEf+J/pRuZizUEuBbHz78NGHBevS3eTsKmD5nICHs2poVXPQ0pMxVmaVU
         YDjS0M8hzZ6EtMK14MBZ2NJ3wyv0q5S/u4eJ2AW0=
Date:   Wed, 19 Aug 2020 08:02:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: Memory window support for rdma_rxe
Message-ID: <20200819050204.GP7555@unreal>
References: <20200819034002.8835-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 18, 2020 at 10:39:46PM -0500, Bob Pearson wrote:
> This a cleaned up resend of an earlier patch set. This set of patches
> implements the memory windows verbs and local send operations. Each of these
> has been tested at a basic level and regressions tests have been run to
> see that basic rxe functionality is OK.

Can you please submit the series together with standard cover-letter
(git format-patch --cover-letter ..) that include diffstat and patch
list.

It is helpful to see the whole picture of expected changes.

Does it pass rdma-core pyverbs tests?

Thanks
