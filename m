Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F11B2BF3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgDUQKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 12:10:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB53C061A10
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 09:10:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so17090474wrp.3
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hA9Qy954PSJGRon4N4Cpq+72wrsDpq/uc+Pe7zQ5JsY=;
        b=oxCsWEzswHj2MaEpSxl/QADcEw1hN35FU4WiBXvI6vVfiD6TlHSaKPGF8aw00nK5Bp
         ghi0sAivCjUVnyiZ3HpbwXd+CrWsgPN+K6IDBL4cANe23GSPknxDdGGiNMCySGJlBFEC
         CVYO6yraohLczq6Dgeou94jj1TeIuIvNpfymlklDB86WaauscXwFIOBA6TI8EaDzBwTk
         MsJcRUjkrJjyWZuTwVXsJM4o9/DU9yqyIrvJlVScOulQWmrJR7Q14cJJoWTcaC4QjAju
         mmbDe1rw1NRmDr88tcb+LzqOEr4KXPxBGfOwChN7fA5wIHarmNKfjTWmT0v3wpilYlu3
         czLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hA9Qy954PSJGRon4N4Cpq+72wrsDpq/uc+Pe7zQ5JsY=;
        b=Ycq4w9p/OHu15liahI/VPLN/p2VsvVO6HxOIncb/jXv+TdFkHEaV8RK3ssQuHtCYNw
         2mPdsXP45an3JctB8iJgNxjB2EXB8D8E8sFIcfWk0LWBqLttqff4gC2sTJCRJxBjAYft
         cfRg5CEmXlHVIBwfpUy/wzKZ7Oi50yMsseBrMygBIonyHVRWta2fxgMRgw/abvw+SwQK
         HhWfTQpenB05Wq5jOsnMdkUTwVFUgoJcRy3AB5A6oZPrVnQ+1lEyullVxi332E0mWwc8
         9dNLMtrdMK/xvVgpb6NzJvZIaCeVCx7RRU2dKHkRG+L9yQ5Oj0kpRTPR/Sy+kV4OaXbv
         lsbw==
X-Gm-Message-State: AGi0PuYen+OO+vi0a+A/ASTOAJmJM5FTsQMdPSzo7GNm/I3suy51guqt
        sh40SEGmJHNgwYZsh4mWtmdufw==
X-Google-Smtp-Source: APiQypKPUwxF1m/meOxyo8UT2vUuEDn8/V6cvLDCU2CzM11alSgsO9WAvOE6f6NV5Bw13UsE+oOM3Q==
X-Received: by 2002:a5d:6a92:: with SMTP id s18mr23093353wru.50.1587485405162;
        Tue, 21 Apr 2020 09:10:05 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id h5sm4587107wrp.97.2020.04.21.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:10:04 -0700 (PDT)
Date:   Tue, 21 Apr 2020 18:10:03 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     davem@davemloft.net, jgg@mellanox.com, dledford@redhat.com,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        kuba@kernel.org, jiri@mellanox.com, dsahern@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V3 mlx5-next 05/15] bonding: Add helper function to get
 the xmit slave based on hash
Message-ID: <20200421161003.GD6581@nanopsycho.orion>
References: <20200421102844.23640-1-maorg@mellanox.com>
 <20200421102844.23640-6-maorg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421102844.23640-6-maorg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Apr 21, 2020 at 12:28:34PM CEST, maorg@mellanox.com wrote:
>Both xor and 802.3ad modes use bond_xmit_hash to get the xmit slave.
>Export the logic to helper function so it could be used in the
>following patches by the .ndo to get the xmit slave.
>
>Signed-off-by: Maor Gottlieb <maorg@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
