Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08187F08A6
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 22:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKEVrr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 16:47:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34468 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfKEVrr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Nov 2019 16:47:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so5263762pff.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2019 13:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bD9Pfo6E9KADPmENlAY0i+0Bkbxo8dabaUZSCC2jnL4=;
        b=SV4vHZ0oy936dxHdCpTBVHXtgNFuRkBAWUNM2Nj62/FQDgNkLVtcbVVM7Ci60+m6Qz
         otbapLSEUKS1db3KXPW78RWIzWcaY1h1wp/1Fh6iFnfDVXWaZYZQ2wHOf9yqKRKBxsAo
         rrvgVHODB6NUIbVj4xWVDwgS5yc8Og/eR9c+eVjI+b1S5ECJ1wiVU8LEEjfsgxr2SR7J
         Ixh9uS7A61uO9Ga1c83ZOWzKn8iKnyA43nsji6CFBDNuMQZJBJU6TOIVz2lTPc8ffCdW
         o+vcYucDVkZudC9iXre4mBz+58/mnO1J8e9RVMGBPog2a0PY/CyHFmTmv/vS4fJvquiN
         g4qw==
X-Gm-Message-State: APjAAAUvsqTElJmhqdD3AgdMQl8jZm4GRO227NypSUUs6k78BjLrhWHR
        0pSwzCkQFXLBeLPz6Fvm4jA=
X-Google-Smtp-Source: APXvYqwHAGx7sF22OznhzX6mZvSQbJcuiMT5w6eF4bfag1zTJPaJ3UKuJ5rw6J+n2XUIXwQ6DHOYWg==
X-Received: by 2002:a17:90a:77c7:: with SMTP id e7mr1540239pjs.133.1572990466354;
        Tue, 05 Nov 2019 13:47:46 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d139sm33744022pfd.162.2019.11.05.13.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 13:47:45 -0800 (PST)
Subject: Re: [PATCH] RDMA/srpt: Report the SCSI residual to the initiator
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
References: <20191105214632.183302-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4beb1b0d-4be4-92ea-2cb1-c6996dc80140@acm.org>
Date:   Tue, 5 Nov 2019 13:47:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105214632.183302-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/5/19 1:46 PM, Bart Van Assche wrote:
> The code added by this patch is similar to the code that already exists
> in ibmvscsis_determine_resid(). This patch has been tested by running
> the following command: [ ... ]

(replying to my own e-mail)

This is version 2 of this patch. The only change compared to the 
previous version is that the datatype of 'resid' has been changed from 
'int' into 'u32'.

Bart.

