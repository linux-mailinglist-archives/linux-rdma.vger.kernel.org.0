Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931F11B5E31
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgDWOqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726323AbgDWOqw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 10:46:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98E6C08E934
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2020 07:46:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so7184642wrx.4
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2020 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZcgmoetuRBAZeNa5mfw4PDcuYHcw6iGM7aPwzZonDkI=;
        b=j0w74IlsfhQmyce6HRGZwYWOqVZ2sK0K8Ovd+T+OrQM48vP6x/ZVOaz2QhI6auUZJ0
         dPDlAUNTIm5+15n5Sip1Xxx6gdqMiyDM3QAbqzv4YkYyATsBhTPoIOGoHvEP4pWkCjbr
         FKrOKyB2RTd7bV8klhEh4XBy7MD7j2/FjJTt+TrY3+7GZ10rKy+7aT1EMZUwN9qw2oml
         l7qKKR6TDtCZ7em8oxi2LlaYdc6y4s9Iee+qofPefE2w4E6SD7gJc/wHHuv54qMCt7Xw
         0XnX1FFQGQ+79oCot2RzuoW8B0TuoQU9bjMjLtUzUiPg9pNvhDR1yopaOwAQGjJMXUhx
         faJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZcgmoetuRBAZeNa5mfw4PDcuYHcw6iGM7aPwzZonDkI=;
        b=VO6owpH+L+bNvQAidCGHwyD6tDM0BDu5Enh4Q8wGyPy25NPiiO5878WyVFbTvIzz7+
         Fis8bZuQo4l3A3ciHylKNnTLj8YnzT8uwsV/HpwpTQjBA8eSSzr1q6ZVxp1nfRwY0zZJ
         /w0DSNmV4I+f/srL2e8Ww6onBuCsaG8d9FDc6OfSJD4SxsMDrwNfi2TJKTRgaUfT5nT3
         3EHySRnHer9V00q8/u5GjB0ZzgObnkMlgqVQHTDQ16EViv4QMLj3/v3LI7jNsSpSj19C
         iBuxpnnNbq2vTSGkprjmrsH6bfFFpXGRG8sIy6zUl0tGHPXftAPfH/CiIdh07kZ6UQSE
         ieKA==
X-Gm-Message-State: AGi0PuZPkMlJ2SFKDG2j0l8vVPcRL048+6/GZLzqwuaQt48dJsU9f5nk
        A4ajb6nyRqHmyfez2a6spgbBpQ==
X-Google-Smtp-Source: APiQypK6jVhM39noK6ufMzeMmbTa+bbhs6TfHlygzQESjL+w6KYooElu1eremhCkpK3cjeHm5Uw2tw==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr5427562wrx.370.1587653210548;
        Thu, 23 Apr 2020 07:46:50 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id f8sm4037401wrm.14.2020.04.23.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 07:46:50 -0700 (PDT)
Date:   Thu, 23 Apr 2020 16:46:49 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     davem@davemloft.net, jgg@mellanox.com, dledford@redhat.com,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        kuba@kernel.org, jiri@mellanox.com, dsahern@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V5 mlx5-next 01/16] net/core: Introduce
 netdev_get_xmit_slave
Message-ID: <20200423144649.GO6581@nanopsycho.orion>
References: <20200423125555.21759-1-maorg@mellanox.com>
 <20200423125555.21759-2-maorg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423125555.21759-2-maorg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thu, Apr 23, 2020 at 02:55:40PM CEST, maorg@mellanox.com wrote:
>Add new ndo to get the xmit slave of master device.
>Caller should call dev_put() when it no longer works with
>slave netdevice.
>User can ask to get the xmit slave assume all the slaves can
>transmit by set all_slaves arg to true.
>
>Signed-off-by: Maor Gottlieb <maorg@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
