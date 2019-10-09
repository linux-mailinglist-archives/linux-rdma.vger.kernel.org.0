Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03B4D1B45
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 23:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfJIVz5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 17:55:57 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:38895 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIVz5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 17:55:57 -0400
Received: by mail-pl1-f174.google.com with SMTP id w8so1712384plq.5
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 14:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rrk3xsYzozVL+R2Yq4Q8B6S7dkqBMoDBM8ADolRGNk0=;
        b=FU9C078dSvDriwlGmKkvpFvyMDuRj24/foyhY5P3aJhVAMyWJHHnpcqTvrdbyywlLj
         /aILo62psJSN1WGsqMVSel2c+Xi1vshUjrW9PzZD+3yZUFfSGQZTP/B7Dch+C74l4SX9
         gP4BAciKw6brE1hHF29YvaZVIDJlNFQvRAXbe6tCnyHqIQpq5EKoGOC9S8NW+3hjM70p
         lVQyz8Me/JRo3rBr9TP53W4YDuboKsQkd6XRPU2kCx1U4H7a7J4Ty+QfgvgQ67m3jS6t
         kalCZPG9cyuQxcSoPY5QGvGagFf97kT0DGHfqQB1KXrpH5y6E35z/Fhwg+vCcqpy4WYy
         RCAw==
X-Gm-Message-State: APjAAAX6dVe8ZIxd72k1vBLSXsdAh4lTEIftfcj5Z3Wf1navh7HsbxGi
        IBF3Y9EpBkT7FyROJmmA/8fcNgMT
X-Google-Smtp-Source: APXvYqzHIguqS+9RF88cHtde10LfxlsJzo34L4zxQr8ZYXVPpJLfwqZ5m+MaZyfDd0XVTurwz3JB0w==
X-Received: by 2002:a17:902:fe91:: with SMTP id x17mr5202743plm.114.1570658155742;
        Wed, 09 Oct 2019 14:55:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id k65sm6133527pga.94.2019.10.09.14.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 14:55:55 -0700 (PDT)
Subject: Re: [PATCH] ib/srp: Add missing new line after displaying
 fast_io_fail_tmo param
To:     Donald Dutile <ddutile@redhat.com>, linux-rdma@vger.kernel.org
References: <20191009164937.21989-1-ddutile@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d5535489-0130-d159-7e3d-bb34d3bc4282@acm.org>
Date:   Wed, 9 Oct 2019 14:55:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009164937.21989-1-ddutile@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/9/19 9:49 AM, Donald Dutile wrote:
> Long-time missing new-line in sysfs output.
> Simply add it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
