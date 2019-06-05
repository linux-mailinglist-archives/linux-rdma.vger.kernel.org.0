Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A68A364A5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFET0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:26:34 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44262 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFET0e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:26:34 -0400
Received: by mail-oi1-f181.google.com with SMTP id e189so12313475oib.11
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G0AP7b9pVPkiUMtPjGm5QsJt34CfStzfzouoT7Gk67M=;
        b=Nq33Y6TQmtNQ1qwS8sO2DXCqWIeqVVKNClaQBcKbzZlr8X4laCyOiAykbFgOQFcqT+
         //188Z/Sxd3Gj5vAIYfvC0IghcMBJtlAZVr/xmuqKWHjiIhDWW/0tJun9ULnZunuVVt/
         TbUvN5hO/7Nl768jBPDZnrUM7qBqsU1z6yOn9id+vfL0DWKLoDF9sAZquGq5TDQ32OEJ
         5CNPAgNtLDREaS2ObUCuMhriw3Eg17a7J7yv0e66kh2YCV3ubsWWbpE6H30BY0iD19PC
         gMdyuvKmcL+UVBHTj0TXs0HZ+5dFyUrZrGeUKtWOBQrAnJC8aCz8pV0yKdRh1Fm4pT01
         dFrQ==
X-Gm-Message-State: APjAAAV6LOFscgv+quDrPOxNMXYArLnJH2T+HoylEmsiZO715NfWZFS1
        gsjXOJ4PKsUATtdWXsoY1sE=
X-Google-Smtp-Source: APXvYqxY1m6JHW/evyYkbfJ5z6t9bmxHU6mdaip7yX0uAHOG4Lw+9M51+SAFE7nWCbmkm3aij4l5DA==
X-Received: by 2002:aca:e044:: with SMTP id x65mr9432136oig.70.1559762793101;
        Wed, 05 Jun 2019 12:26:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id g10sm3726871otg.81.2019.06.05.12.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:26:32 -0700 (PDT)
Subject: Re: [PATCH 06/20] RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
 mlx5_ib_alloc_mr_integrity
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-7-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8569880c-d6c1-c70b-90d8-569b211f9185@grimberg.me>
Date:   Wed, 5 Jun 2019 12:26:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-7-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks reasonable to me, other than the return status question I had,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
