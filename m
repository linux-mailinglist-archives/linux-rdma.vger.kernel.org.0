Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEBCFFDAB
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 05:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfKRE7i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 23:59:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42281 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRE7i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Nov 2019 23:59:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so9035482plt.9
        for <linux-rdma@vger.kernel.org>; Sun, 17 Nov 2019 20:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ryussi-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7CVKJX4iKY/TyW+AjcBFkCW+JCWb9TO+uAsM/3K11s0=;
        b=XzKqzgTFDiAjJsqjbko2C8EtVXoL9hlbcC4IzsRAXtyiFzdKvvRHI2BryEjrm4b2YO
         /S+0+QIdyQ4AkqXsugG4wCIAVVaoX1UtS2ruDuJjC+7mft1sj+0B4WMagWSf6xMmrdOJ
         dXLP81WTShGVAoRsUGhNTR6cPAqgeMEvnQbezcRZMKlgDYkrQFcgzV1w5E7ELsKwGZX2
         2JQQEDFHf0UD6hQzTr3I4I0ctiiG2uZ2nJM8INyIniNUREPhNpul42Ks2MktoH/xUw6M
         0irvj2TOi2DtKXHzHE67AgvBVrlxM/ZuUAXHikYzmObTovfxkEevexHk6Mo3BdNF26Rt
         vpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7CVKJX4iKY/TyW+AjcBFkCW+JCWb9TO+uAsM/3K11s0=;
        b=HYMvZ2XOywArjgUsrlk28c8HknffTtUkhX3bQo50sJqyIvPZTPk0lv8PWPEB1dIf65
         KKzUAB0QLMiXdbu3ESVMtlIUSn2jqsw1kacxvYTjJN8+/RczlWzhaVL3Q/HEixi7UeFi
         RHcafYCslNV4PNVnRQHOMJOpGTzRCxk3njK0Bx5q0uksR3zRDuWdEjXzBbDVhFbz3vrc
         pigq7zZRKXW0XwAZRXg28AC4sW99RQ5FOdVYqUC+sf+uLxCx71usK9rCiZZ0LkUdRrFR
         eNJSP+PYz9TezZl8wJVMmUA9DsFTncBWotdRDWsxfGhnUjZIKo2EiUHqKprs2JwN/6d2
         aoig==
X-Gm-Message-State: APjAAAXeLEqCWC/wmqyo6Sup7AITf9E01uicz1ZumrE9nEKV4FSYGdYh
        o6ncyJd9//NKbVm5/UXhXvKCd5OE7jQ=
X-Google-Smtp-Source: APXvYqyxO645VOu0HSClxidfDJSaXFFaUcHtuyt/g9x68hTallClJdTcATiab5fRVaiV+iRc9HfDJw==
X-Received: by 2002:a17:90a:a58b:: with SMTP id b11mr37417244pjq.46.1574053176883;
        Sun, 17 Nov 2019 20:59:36 -0800 (PST)
Received: from [172.31.254.84] ([182.73.204.74])
        by smtp.gmail.com with ESMTPSA id p3sm20238000pfb.163.2019.11.17.20.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 20:59:36 -0800 (PST)
Subject: Re: [question] ibv_reg_mr() returning EACCESS
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <141f4c07-b7f1-1355-7ff7-d62605ee63b5@ryussi.com>
 <20191115141210.GC4055@ziepe.ca>
From:   Vinit Agnihotri <vinita@ryussi.com>
Message-ID: <cc6543bd-0c8d-40e3-f384-68a847b873b3@ryussi.com>
Date:   Mon, 18 Nov 2019 10:29:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115141210.GC4055@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thank you Jason.

I did went through archives for the same.

Can you please provide pointer towards documentation or

sample userspace usage for the same? Or which kernel version to be 
looked into?


Thanks & Regards,

Vinit.

On 15/11/19 7:42 PM, Jason Gunthorpe wrote:
> On Fri, Nov 15, 2019 at 09:27:40AM +0530, Vinit Agnihotri wrote:
>> Hi,
>>
>> I am trying to use setfsgid()/setfssid() calls to ensure proper access check
>> for linux users.
>>
>> However if user is non-root then ibv_reg_mr() returns EACCESS. While I am
>> sure I am calling ibv_reg_mr()
>>
>> as root user, not sure why it still returns EACCESS.
>>
>> While going through libibverbs sources I realize EACCESS might be returned
>> by this call:
>>
>> if (write(pd->context->cmd_fd, cmd, cmd_size) != cmd_size)
>>          return errno;
>>
>> Can anyone provide any insight into this behavior? Does calling these
>> systems calls in threads can affect
>>
>> entire process? I checked /dev/infiniband/* has appropriate privileges.
> This is a security limitation, if you want do this flow you need a new
> enough kernel and rdma-core to support the ioctl() scheme for calling
> verbs
>
> Jason
