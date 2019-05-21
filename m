Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0531424DB0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfEULMv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 21 May 2019 07:12:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36559 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfEULMv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 07:12:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so28828366edx.3
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 04:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zbfbsZ00BzTGr9D7X5h8lh8xvNwkVCme4sOpVqk+cTo=;
        b=E7HJF0/nNYHegffqcGknfw5gcHKm6Mwc0Z0fe/bUnrnyRRIK1Sx3l+CV/0rzod0cad
         kBps0Irgv7lKkVTTXbs6//Id23XYh82QfzIHijX8jEMXTrUluwro7igO2K08GXCeyFJN
         /eNl/6YfDhwYfrsolagxGSw6MDFiD4lzDv8wDdvr3ow1tCezv7RQfWaNccWXI+696Is+
         I5zHq2uajoCecVsEVrXzcE7w4DFjuyFhqqf5LxIDlkQ3QEygVvuMBUBkJDsEyU2UmrEY
         PHOE5SyJWH0ZgFLFG87AZX+GrTFz1O1HCWGeDNPoEfVT40Jm3lfT8N448x67QJtAsBNJ
         4aLg==
X-Gm-Message-State: APjAAAVR8lRbQMLzXOdVETFLkmeOiBMO+GTl24CBEleUcYNvJ+x5Yd7F
        HMdZvoVbjkxSQz0m2ef1QnQjVut8
X-Google-Smtp-Source: APXvYqyeFCNGpIaIbs9sTSxCrnBwxPi9x7oMPV+5Nb7R6RsFX5tchkYSLf3zfE/YsUh4rPMvK8BwZg==
X-Received: by 2002:a17:906:68c8:: with SMTP id y8mr47078976ejr.104.1558437169218;
        Tue, 21 May 2019 04:12:49 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id v2sm6155290eds.69.2019.05.21.04.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 04:12:45 -0700 (PDT)
Subject: Re: [PATCH rdma-next v4] RDMA/srp: Rename SRP sysfs name after IB
 device rename trigger
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190517124310.14815-1-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <72eb677a-5c76-cdce-eff8-02b8d263f47e@acm.org>
Date:   Tue, 21 May 2019 13:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517124310.14815-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/17/19 2:43 PM, Leon Romanovsky wrote:
> This panic is caused due to races between device rename during boot and
> initialization of new devices for multi-adapter system.
> 
> The module load/unload sequence was used to trigger such kernel panic:
>  sudo modprobe ib_srp
>  sudo modprobe -r mlx5_ib
>  sudo modprobe -r mlx5_core
>  sudo modprobe mlx5_core

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

