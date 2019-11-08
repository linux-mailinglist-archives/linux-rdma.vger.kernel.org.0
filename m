Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B8F4002
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 06:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfKHFco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 00:32:44 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:32979 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfKHFco (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 00:32:44 -0500
Received: by mail-pl1-f182.google.com with SMTP id ay6so3321482plb.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 Nov 2019 21:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ryussi-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=RZqH1o5kvh8T6TYj3mlSRaJwSoWJueTi8ywp07LVwFw=;
        b=pymWRnO8zuCH6lbPDExlYESMue8Viofbu8nsHIwLha3CoukoWxZGuV9zN8tzo4sqng
         RINSva0c351SKarctMHuTeK3NlN+CQbHG5NqN7f2ZtIralvCDShAImCWRlwFGyu7QRFu
         ko9+RZ+iALEF9ecIHp+d+wEfJpfl8vrzS0kyUjQGZtutUnABBiucZ86ogbSViUsqMfm5
         PWfPqUHdKYx4kZRSJe6m2Epgf466Inlf7/Zk9TFarZoHqdPi2SCEI7kmxt8iR3Sk6lGN
         p8Ch8dOUoeCLKpyRaBGfzSXvt/5sqnk0ameAQBBR/zUmJJMB1pkwnpnp0B37EqpuBdZT
         qolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=RZqH1o5kvh8T6TYj3mlSRaJwSoWJueTi8ywp07LVwFw=;
        b=gyaLBZLQEsfN3anH2BfzBxGZnM9SJ3No7tOmk29AtWpKRI6r7SYb0iuEuomCfjHXsd
         5U7ukceudGcrmJ7u8rw5dL3Wt3Z5fyQBc3KBc/8RxHVKKIvLL0TjdeYzXjoQackuLuV3
         ixXB5IZLqjfExIAXUixeTlMz711v7+ADk2x/OgF+OJtTl6gPN1TG+mJYOBTlmFbdA4Tk
         38AEfizDmH6EFdP33Pi6IIIShndL8KjwaqtaW/1xkuXzg4UbzUzjmZ2bOAB7gu1uwijg
         gRMF2rDgVfMk16TTpDbHWx7U4+fWo7A34IkMayyDk05QdFM4nzwwcwBDml1HjLF5rF9y
         CucA==
X-Gm-Message-State: APjAAAWxbCr+oOUSqEPfYTYPthmskIx0mizgyomTO27DkpWgCnn2EIW+
        o90te6rhQZtzoh3XUTLnBFh4eZfOjPE=
X-Google-Smtp-Source: APXvYqyr1FY8GBa395C/t5REIH7tNI+DE2vVzkggV0i6hhKxE02qv5uSYSzPuJdFm7igbNR/i3OlqA==
X-Received: by 2002:a17:902:82cb:: with SMTP id u11mr7900511plz.165.1573191163413;
        Thu, 07 Nov 2019 21:32:43 -0800 (PST)
Received: from [172.31.254.84] ([182.73.204.74])
        by smtp.gmail.com with ESMTPSA id d25sm5229836pfq.70.2019.11.07.21.32.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:32:42 -0800 (PST)
To:     linux-rdma@vger.kernel.org
From:   Vinit Agnihotri <vinita@ryussi.com>
Subject: Unable to register memory, ibv_reg_mr returning EACCESS
Message-ID: <06a5eab8-6341-850a-46cd-8dfedfb63da9@ryussi.com>
Date:   Fri, 8 Nov 2019 11:02:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

we have a userspace server which would allow user to access files using 
his/her own credentials via UID mapping.

while we are running server as root user, but to in order to honor posix 
mappings, we use  setfsgid()/setfssid() before

accessing any file and restore them back to user access. However when we 
try to ibv_reg_mr() EACCESS is returned.

We are ensuring to be root before we call to ibv_reg_mr(), yet it keeps 
failing.

While going through libibverbs sources we realize EACCESS might be 
returned by this call:

if (write(pd->context->cmd_fd, cmd, cmd_size) != cmd_size)
         return errno;


As we are ensuring that setfsgid()/setfssid() are set to root before we 
call to ibv_reg_mr(), why EACCESS is still returned?

Since these calls are thread specific only why it should affect entire 
process?

Can anyone provide any insight into this behavior?


Thanks & Regards,

Vinit.


