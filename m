Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4835F1B2B95
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDUPuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgDUPuT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 11:50:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C658BC061A10
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 08:50:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so16971710wrg.11
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dXutNfzEPPBIzXty8l2eHHHrm6BjNMm38FPBlcpDxUo=;
        b=K7DrT8VMr3mDm7ooXxgQgk/tXFdqfAUvBXmJXeCgJLphU3s8GbCrp/LWX1sjZHSgtu
         NnKo8/oQpCepO1+dRNMyeGXoAFiQ5Hc3vJodl5IldsGzBhCZClqWJ/oCBDm3yVLasRmp
         NfM2XtmHz+odyb4zdd9QUAhcP48UleXn57Te41f5iPGjrZ0fCi22HpSH1jmbg9mFp7+J
         P2KRlq91HEl9SKcTZLz8lnS9zXPyh69SC+/dB9e12kuHTEvtcv48dMxDw/C6DYZ58EvM
         qI4vWrUKAGTJ7QMjLNy0LP6/Or4OMsPlawaDpugVX0/acngL+gi6WVVVN6P2Olm3Upyh
         Os6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dXutNfzEPPBIzXty8l2eHHHrm6BjNMm38FPBlcpDxUo=;
        b=XokFt7YEgyJwG83AokqvgOGIS5Ae3A7+T3p257knRvzL5s0N3CR1l1HZe8U+bA6A2z
         8BrdyitWCOzt1DN6uGIrYQkXX5WL0wVzKQjwhRxJ65OvVOf6584QomOSTfSIMZl0xajO
         7UCA9iP8tYhBQBMS2HmW/eNlPYonRZijjxj6mJLh8hKiOL8ZmgvjMmUF48dLWM7a7j5o
         AIuc1AFcsRjDUg5veVSwrS0wsDqjH+dBkLQPclRfI+S7H7vtIFw2j9Yk/GhE2rP5g68y
         n21aDhpAnWAy6O96D/r9HnO5pNVqA6jySIyzSt1k9D8Kh5SXkv5RTZooJh5hMBfKaBN+
         h4cQ==
X-Gm-Message-State: AGi0Puabd8rfK9wRAnlJzV3F0MmqgHUdeCY6uIcpJmJ4d/SMms/EJHnw
        ejRAFDtkPjn69t/L06vCpuKzxQ==
X-Google-Smtp-Source: APiQypKsPsSyavO3XM4LnsBGvwkeDRyDzVCJKnACoJCk2EMzBYPOT/O/I2096wlZR8tWs0wCL2Gplw==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr15674110wrt.163.1587484217570;
        Tue, 21 Apr 2020 08:50:17 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id k9sm4196577wrd.17.2020.04.21.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:50:17 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:50:16 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     davem@davemloft.net, jgg@mellanox.com, dledford@redhat.com,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        kuba@kernel.org, jiri@mellanox.com, dsahern@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V3 mlx5-next 02/15] bonding: Export skip slave logic to
 function
Message-ID: <20200421155016.GA6581@nanopsycho.orion>
References: <20200421102844.23640-1-maorg@mellanox.com>
 <20200421102844.23640-3-maorg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421102844.23640-3-maorg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Apr 21, 2020 at 12:28:31PM CEST, maorg@mellanox.com wrote:
>As a preparation for following change that add array of
>all slaves, extract code that skip slave to function.
>
>Signed-off-by: Maor Gottlieb <maorg@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
