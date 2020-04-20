Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F02A1B1521
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgDTSsP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgDTSsO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Apr 2020 14:48:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A4AC061A0F
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 11:48:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so11463129wrb.8
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2cSdc7HOKNn19uIovkBV2qQLh5+gmDP21h5U9G3vQpg=;
        b=AWt7dvWRP+vAoE+odGSw7XNnLZObieoTenf9eCtsh7RVN/TGFvcAACtffqBThNrcS3
         zlsMF/jJreikztfpiqVKzjgSIFM4qjed8tvPnuxNNDLP15XzxLkr0h/PGgSII0P0sAqF
         lmVeVm3FrGFdKB9eeAyOzIeGYwO8v/NwLvBei3p0LWS3CINC+60AS1V5JXMUEs5ANHZI
         QKB+6lyaSIJTmKFQSohenGvdTEm+yBs4CtxG6NyqvCiCKgj0F9C+aT26ElLTWuwdi0m9
         rFDTH48y22+S/y70iDfaE+cpCiet5XiTzu+otbKEcVlIXWzbkw32YpaEkctMGDMAZGp8
         ym3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2cSdc7HOKNn19uIovkBV2qQLh5+gmDP21h5U9G3vQpg=;
        b=CWHQ76jbf2u561FhJ5T429SlMwbbHL5ybipyv8T/W1K2ujYLl8UG10ss/pjiO0UJ4G
         su9NSutSsPkIVVlQzW13whiDz2SsswiteDJ2e6utmT91hU/aR7AduYn9rYDUbExpiR8x
         sArQl3zZvNxyjuwgJtP/GFRB0QsuTQTK7NqZu0DgKtXYvMdsojLaVPT7iGdkzfOrFRRn
         iv94j3IIxUNVdnL0XiOg3GXRVwDT0w4+9qgyYsqzyym7ftdv35r9NDWdWntUP1peybeA
         gthgA8q4H8I1kbyCjY4XJE0DDLE89CDbgmnH4drOyEexsohCb1BevnJGQuKBkBds6xtY
         Hoqg==
X-Gm-Message-State: AGi0Pua4NeqLLO4w7lv8R8kILJssxiX7E5GnE5o3e4phrbnBTkvLLIh5
        d9Arx08p1QW+UF2ASDbNyXfvAQ==
X-Google-Smtp-Source: APiQypJTmGD6w4kcJc/Jb8LZ9aIRN3E+NN52Jim9VsAd/ZOeMB8QLIvIrgK3iYSjr2bKc6PscVe0HQ==
X-Received: by 2002:a5d:610e:: with SMTP id v14mr19672293wrt.159.1587408493333;
        Mon, 20 Apr 2020 11:48:13 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id y63sm386040wmg.21.2020.04.20.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:48:12 -0700 (PDT)
Date:   Mon, 20 Apr 2020 20:48:11 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Ahern <dsahern@gmail.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, davem@davemloft.net,
        jgg@mellanox.com, dledford@redhat.com, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net, kuba@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com, jiri@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V2 mlx5-next 01/10] net/core: Introduce
 master_xmit_slave_get
Message-ID: <20200420184811.GW6581@nanopsycho.orion>
References: <20200420075426.31462-1-maorg@mellanox.com>
 <20200420075426.31462-2-maorg@mellanox.com>
 <20200420140118.GJ6581@nanopsycho.orion>
 <a9e00f31-2f4e-1dfc-2464-d3d25376a4b8@gmail.com>
 <20200420175421.GU6581@nanopsycho.orion>
 <916ab047-3b50-7104-311a-6dcf604bcf6d@gmail.com>
 <20200420180144.GV6581@nanopsycho.orion>
 <75dffa6a-c14f-45c9-44e1-bf5b5c650a9b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75dffa6a-c14f-45c9-44e1-bf5b5c650a9b@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mon, Apr 20, 2020 at 08:04:01PM CEST, dsahern@gmail.com wrote:
>On 4/20/20 12:01 PM, Jiri Pirko wrote:
>> Generic ndo with lag-specific arg? Odd. Plus, there is a small chance
>> this is ever going to be used for other master. And if so, could be very
>> easily renamed then...
>
>core code should be generic, not specific and renamed at a later date
>when a second use case arises.

Yeah, I guess we just have to agree to disagree :)

