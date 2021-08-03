Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801643DF458
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhHCSIH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234371AbhHCSIH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DE0060FC2;
        Tue,  3 Aug 2021 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628014075;
        bh=LMFNerc3lsLJ5jo+sKBig2IV8c8DDozUl51hQbG9kbU=;
        h=Date:From:To:Cc:Subject:From;
        b=NNBpbK76g/WaR6NjI5SAVFrpH4qWpF0VuAw8g8NCVytC4DDmKu/Q424L7qgIszCVC
         fxOnGYGBhAG1Mr4h8CbIqtWUY5Wt3M+pwlN9y7AcxqAhJLLkrLNOjZxX92r+XcS9v/
         Jo6+MXZG2LHoGYv4mS/jyIREEPxtLSyrNySZOvf3EXjarQA0KjDzWHXTXGSly7Apzp
         3ZfIwCREiM0y6C81s/ZgFJB3jOqwtxpgJejuymmNlm3IBr6QJ3XRP7zWmEyMv99Ln+
         cqVQeQ5aZgeHA4NIFhyVQ9JWk4WR8wKd5gDi9ltN77tZpoF3zdb1N6F2C78QtMemot
         w4GPYzCOyfmRA==
Date:   Tue, 3 Aug 2021 21:07:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: RXE status in the upstream rping using rxe
Message-ID: <YQmF9506lsmeaOBZ@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Can you please help me to understand the RXE status in the upstream?

Does we still have crashes/interop issues/e.t.c?

Latest commit is:
20da44dfe8ef ("RDMA/mlx5: Drop in-driver verbs object creations")

Thanks
