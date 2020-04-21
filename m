Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598461B30A4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 21:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDUTuA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 15:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgDUTt7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Apr 2020 15:49:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C48FC0610D5
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 12:49:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k11so18006833wrp.5
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5VAz9Z6qz0Xs9V4YS/3+aj+082XPMEMOFZkK+7BlJ5I=;
        b=Jv1Z0mjjvpf2h2Kb6XQ2T4hJtON1N3E7oR90gFs7c+7QNHN73CXYMXA7YVzjnDDo2+
         PD4CpCJpdBmOn3D/afRDfPQdFgES36Z6Za72qIixqqRcwv3Pvt0J1hZwk7dTv9ttth4D
         wv/CdCqYdituL+5RRR6ZQAjQtWPnwMmRmpbFSPNBMuRZ7MUeu0bzsZvOi3x71drRGP6G
         gUHWD8UEizWJAErLAIDCEzoGo5WoJWBbzwQyw+C/LHO1nP0eZpDydO7eIoBj5+lNRaYL
         bXBmDQME/JAJCk+ON1sl7drTC20YN+V+W5FhwwEo4XzcVL9PweviQ7TEdz8uxEjkV91S
         JZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5VAz9Z6qz0Xs9V4YS/3+aj+082XPMEMOFZkK+7BlJ5I=;
        b=f605U6s+Go8cR5d/aRmgIem3owYYZdcyyeiy/HiAsEg3CE+fnMHHOX+tYZm78r01Kx
         HyMpdA3v7T66i3vPDwWjo2ckXNDwnybov92a6lScczIu3YwkeRnSOXZ4Z2c1FvzBVGHc
         remXlgePSmpWwztKXCE8k9UAENR2QZRQ51bSF78lHOM71jUXeav/H2BJt0UzRIfKJqQ6
         IMjdG04yP5rywXxEokSzjMqDN7BctBfZ0gquPZfJKpNlX7eLhN0izh+lAslLkVzQs1m/
         hoAHOpKAwOVKwhlR4WGixbQj9+zSRRmAJJKHxYPiCrav7MVsLVr7XEae3+TOtbk+OspA
         TNVQ==
X-Gm-Message-State: AGi0Pubd99OGWxz2ToCov68XLRnKdum5/4+N4/uDU5YzK7zQgLaVhjrP
        5QMpsmrcrq7narctB9eMeT0ELA==
X-Google-Smtp-Source: APiQypLgmZwO5w5Lwz0Pydk81hrBazNbDFTtXIhQr/wEN/p4FT6POxSyspMv/cua1K9Vl1qwFpUx3Q==
X-Received: by 2002:a05:6000:114c:: with SMTP id d12mr10276787wrx.381.1587498598074;
        Tue, 21 Apr 2020 12:49:58 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id i25sm4733969wml.43.2020.04.21.12.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:49:57 -0700 (PDT)
Date:   Tue, 21 Apr 2020 21:49:56 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     davem@davemloft.net, jgg@mellanox.com, dledford@redhat.com,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        kuba@kernel.org, jiri@mellanox.com, dsahern@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V3 mlx5-next 09/15] bonding: Implement ndo_get_xmit_slave
Message-ID: <20200421194956.GH6581@nanopsycho.orion>
References: <20200421102844.23640-1-maorg@mellanox.com>
 <20200421102844.23640-10-maorg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421102844.23640-10-maorg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Apr 21, 2020 at 12:28:38PM CEST, maorg@mellanox.com wrote:
>Add implementation of ndo_get_xmit_slave. When user set all_slaves
>to true, the xmit slave result is based on the hash, then the slave
>will be selected from the array of all the slaves.

Reading this sentence multiple times, does not make sense to me :/ Could
you rephrase please?

The code looks fine.
