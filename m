Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07D1B2BA6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDUPwL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbgDUPwK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 11:52:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF3C061A41
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 08:52:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so15823981wrw.7
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u0wltD4ulxCkwqlLtvngLBvyLIzVHV6sPWpGQHNj2Gc=;
        b=tPKYSq998p9C1Q/10nqU/ysDB6yyPCnSsFKd0wDR1AZ9zEVStdv+LvYj36Ndd97TiM
         8qbYkZtgTgHbyYnvNpPNI+i++sbZxIH67tcDt2Jc9Yw+EolYC+4sG97wxakWEhVbge3v
         npcNmFfwG1He05UPHy7JTL1fh5vXWQ8OIVzzvmtIp7E7cJqGoJ4fJeNiZrEOFp/3Sfuz
         ApjeW5Fo1G3Jt3NmHNZkmDCggZ9pDRE3qZOTs1n0HCzkU0snSSjt8axaspJp4YU5/YVv
         YZ9NYSSsCvgsVN4jzU0xev9+KiwQmB1pM1QIcCWND5xAysdYkOpfUIhm3lcis700fDsD
         7sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u0wltD4ulxCkwqlLtvngLBvyLIzVHV6sPWpGQHNj2Gc=;
        b=An/W8nlUXO7wCAbujoGFfbXQcSb7q+A9rmZt6YUUDqJyr4Z3iqFqWbVtHs8CjLozhz
         eQNb5w2K4GAFg6YmSnt4Ky+QBIBQ4j45dluZFsYLgrJ+SDXcD841YHzFwDiufLZyg2Cr
         gmfX6qAAnFB5mKOStiO4vbbayyJC1YafD/jlxzxXGgWT6IN26A4Zx6rpCFGoG4T0Pze4
         mhRgsyJ+lac+fd8tu2pkbxkUWtKcW09mEB7+0I07Y99gMya1vH0DMrfq0eFdK0uwZrUV
         O1h8OaeoVkKJjUXsUw1YOEtsnsUyZ7lmKcFHSgkS0wyB3BNzeRHz3HuQenEmF65Im7ws
         NS+Q==
X-Gm-Message-State: AGi0PuZoCzywaU5So+5t97MyUcggbrrUgv0TV4s1A48W124OqucEF9Da
        ++GTSAO0lAowJtGR2fwSEP0V5w==
X-Google-Smtp-Source: APiQypIL/PW1mtTGeYYsEpuNsBi/zLJsEtOcd9WPaF6Vli2ytTzZWrXEG9j7tzeNJ+PPg1q5mYXzRg==
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr26231154wrw.277.1587484328663;
        Tue, 21 Apr 2020 08:52:08 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id g25sm3859102wmh.24.2020.04.21.08.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:52:08 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:52:07 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     davem@davemloft.net, jgg@mellanox.com, dledford@redhat.com,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        kuba@kernel.org, jiri@mellanox.com, dsahern@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V3 mlx5-next 03/15] bonding: Rename slave_arr to
 usable_slaves
Message-ID: <20200421155207.GB6581@nanopsycho.orion>
References: <20200421102844.23640-1-maorg@mellanox.com>
 <20200421102844.23640-4-maorg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421102844.23640-4-maorg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Apr 21, 2020 at 12:28:32PM CEST, maorg@mellanox.com wrote:
>Rename slave_arr to usable_slaves, since we will have two arrays,
>one for the usable slaves and the other to all slaves.
>
>Signed-off-by: Maor Gottlieb <maorg@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
